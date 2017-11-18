//
// © 2017 @toddheasley
//

import Cocoa
import MapKit
import BoatsKit

class CoordinateInput: Input, NSTextFieldDelegate, MKMapViewDelegate {
    private let textField: (latitude: NSTextField, longitude: NSTextField) = (NSTextField(), NSTextField())
    private let map: (view: MKMapView, center: NSView) = (MKMapView(), NSView())
    
    var coordinate: Coordinate {
        set {
            textField.latitude.doubleValue = newValue.latitude
            textField.longitude.doubleValue = newValue.longitude
            map.view.region = MKCoordinateRegion(center: CLLocationCoordinate2D(coordinate: coordinate), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        }
        get {
            return Coordinate(textField.latitude.doubleValue, textField.longitude.doubleValue)
        }
    }
    
    override var u: Int {
        return 14
    }
    
    override func setUp() {
        super.setUp()
        
        textField.latitude.delegate = self
        textField.latitude.placeholderString = "Latitude"
        textField.latitude.frame.size.width = (intrinsicContentSize.width - ((contentInsets.left + contentInsets.right) * 1.5)) / 2.0
        textField.latitude.frame.size.height = 22.0
        textField.latitude.frame.origin.x = contentInsets.left
        textField.latitude.frame.origin.y = labelTextField.frame.origin.y - textField.latitude.frame.size.height
        addSubview(textField.latitude)
        
        textField.longitude.delegate = self
        textField.longitude.placeholderString = "Longitude"
        textField.longitude.frame.size = textField.latitude.frame.size
        textField.longitude.frame.origin.x = intrinsicContentSize.width - (textField.longitude.frame.size.width + contentInsets.right)
        textField.longitude.frame.origin.y = textField.latitude.frame.origin.y
        addSubview(textField.longitude)
        
        map.view.delegate = self
        map.view.frame.size.width = intrinsicContentSize.width - (contentInsets.left + contentInsets.right)
        map.view.frame.size.height = textField.latitude.frame.origin.y - (contentInsets.top + contentInsets.bottom)
        map.view.frame.origin.x = contentInsets.left
        map.view.frame.origin.y = contentInsets.bottom
        addSubview(map.view)
        
        map.center.wantsLayer = true
        map.center.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.5).cgColor
        map.center.layer?.cornerRadius = 20.0
        map.center.frame.size.width = 40.0
        map.center.frame.size.height = 40.0
        map.center.frame.origin.x = map.view.frame.origin.x + ((map.view.frame.size.width - map.center.frame.size.width) / 2.0)
        map.center.frame.origin.y = map.view.frame.origin.y + ((map.view.frame.size.height - map.center.frame.size.height) / 2.0)
        addSubview(map.center)
        
        label = "Coordinate"
    }
    
    // MARK: NSTextFieldDelegate
    override func controlTextDidChange(_ obj: Notification) {
        map.view.centerCoordinate = CLLocationCoordinate2D(coordinate: coordinate)
    }
    
    // MKMapViewDelegate
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        textField.latitude.doubleValue = mapView.centerCoordinate.latitude
        textField.longitude.doubleValue = mapView.centerCoordinate.longitude
    }
}

