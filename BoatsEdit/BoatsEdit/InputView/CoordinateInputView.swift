import Cocoa
import MapKit
import BoatsKit

class CoordinateInputView: InputView, NSTextFieldDelegate, CoordinateMapDelegate {
    private let textField: (latitude: NSTextField, longitude: NSTextField) = (NSTextField(), NSTextField())
    private let mapView: CoordinateMapView = CoordinateMapView()
    
    private func format(_ double: Double) -> String {
        let string: [String] = "\(double)".components(separatedBy: ".")
        if string.count == 2, string[1].count > 7 {
            return String(format: "%.7f", double)
        }
        return string.joined(separator: ".")
    }
    
    var coordinate: Coordinate? {
        set {
            textField.latitude.stringValue = format(newValue?.latitude ?? 0.0)
            textField.longitude.stringValue = format(newValue?.longitude ?? 0.0)
            mapView.coordinate = CLLocationCoordinate2D(coordinate: coordinate!)
        }
        get {
            return Coordinate(textField.latitude.doubleValue, textField.longitude.doubleValue)
        }
    }
    
    // MARK: InputView
    override func setUp() {
        super.setUp()
        
        contentView.frame.size.height = labelTextField.frame.size.height + 338.0
        
        mapView.delegate = self
        mapView.frame.size.width = contentView.bounds.size.width
        mapView.frame.size.height = 310.0
        contentView.addSubview(mapView)
        
        textField.latitude.delegate = self
        textField.latitude.placeholderString = "Latitude"
        textField.latitude.frame.size.width = (contentView.bounds.size.width / 2.0) - 3.0
        textField.latitude.frame.size.height = 22.0
        textField.latitude.frame.origin.y = 316.0
        contentView.addSubview(textField.latitude)
        
        textField.longitude.delegate = self
        textField.longitude.placeholderString = "Longitude"
        textField.longitude.frame.size = textField.latitude.frame.size
        textField.longitude.frame.origin.x = contentView.bounds.size.width - textField.longitude.frame.size.width
        textField.longitude.frame.origin.y = textField.latitude.frame.origin.y
        contentView.addSubview(textField.longitude)
        
        label = "Coordinate"
        coordinate = Coordinate(0.0, 0.0)
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidEndEditing(_ obj: Notification) {
        mapView.coordinate = CLLocationCoordinate2D(coordinate: coordinate!)
        
        delegate?.inputViewDidEdit(self)
    }
    
    // MARK: CoordinateMapDelegate
    fileprivate func coordinateDidChange(map: CoordinateMapView) {
        textField.latitude.stringValue = format(map.coordinate.latitude)
        textField.longitude.stringValue = format(map.coordinate.longitude)
        
        delegate?.inputViewDidEdit(self)
    }
}

fileprivate protocol CoordinateMapDelegate {
    func coordinateDidChange(map: CoordinateMapView)
}

fileprivate class CoordinateMapView: NSView, MKMapViewDelegate {
    private let mapView: MKMapView = MKMapView()
    private let target: NSView = NSView()
    private let button: (overlay: NSButton, lock: NSButton) = (NSButton(), NSButton())
    
    var delegate: CoordinateMapDelegate?
    
    var coordinate: CLLocationCoordinate2D {
        set {
            mapView.delegate = nil
            mapView.centerCoordinate = newValue
            mapView.delegate = self
        }
        get {
            return mapView.centerCoordinate
        }
    }
    
    var isLocked: Bool {
        set {
            mapView.isScrollEnabled = !newValue
            button.overlay.isHidden = !newValue
            button.lock.image = NSImage(named: newValue ? NSImage.lockLockedTemplateName : NSImage.lockUnlockedTemplateName)
        }
        get {
            return !button.overlay.isHidden
        }
    }
    
    @objc func toggleLock(_ sender: AnyObject?) {
        isLocked = !isLocked
    }
    
    // MARK: NSView
    override func scrollWheel(with event: NSEvent) {
        guard mapView.isScrollEnabled else {
            nextResponder?.scrollWheel(with: event)
            return
        }
        super.scrollWheel(with: event)
    }
    
    override func layout() {
        super.layout()
        
        button.lock.frame.origin.x = bounds.size.width - button.lock.frame.size.width
        button.lock.frame.origin.y = bounds.size.height - button.lock.frame.size.height
        
        target.frame.origin.x = (mapView.frame.size.width - target.frame.size.width) / 2.0
        target.frame.origin.y = (mapView.frame.size.height - target.frame.size.height) / 2.0
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        
        wantsLayer = true
        layer?.borderColor = NSColor.gridColor.cgColor
        layer?.borderWidth = 0.5
        
        mapView.delegate = self
        mapView.showsZoomControls = true
        mapView.region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        mapView.autoresizingMask = [.width, .height]
        mapView.frame = bounds
        addSubview(mapView)
        
        target.wantsLayer = true
        target.layer?.borderColor = NSColor.text.cgColor
        target.layer?.borderWidth = 0.5
        target.layer?.cornerRadius = 11.0
        target.frame.size.width = 22.0
        target.frame.size.height = 22.0
        mapView.addSubview(target)
        
        button.overlay.target = self
        button.overlay.action = #selector(toggleLock(_:))
        button.overlay.isTransparent = true
        button.overlay.wantsLayer = true
        button.overlay.layer?.backgroundColor = target.layer?.backgroundColor
        button.overlay.autoresizingMask = [.width, .height]
        button.overlay.frame = bounds
        addSubview(button.overlay)
        
        button.lock.target = self
        button.lock.action = #selector(toggleLock(_:))
        button.lock.isBordered = false
        button.lock.frame.size.width = 53.0
        button.lock.frame.size.height = 49.0
        addSubview(button.lock)
        
        isLocked = true
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        delegate?.coordinateDidChange(map: self)
    }
}