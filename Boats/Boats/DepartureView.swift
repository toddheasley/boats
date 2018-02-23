import UIKit
import BoatsKit

class DepartureView: UIView, ModeTransitioning {
    enum Status: String {
        case none = ""
        case next
        case last
    }
    
    private let contentView: UIView = UIView()
    private let timeView: TimeView = TimeView()
    private let iconView: IconView = IconView(icon: .car)
    private let statusLabel: UILabel = UILabel()
    
    var localization: Localization? {
        set {
            timeView.localization = newValue
        }
        get {
            return timeView.localization
        }
    }
    
    var departure: Departure? {
        didSet {
            timeView.time = departure?.time
            statusLabel.isHidden = departure == nil
            iconView.isHidden = !(departure?.services.contains(.car) ?? false)
        }
    }
    
    var status: Status = .none {
        didSet {
            statusLabel.text = status.rawValue.uppercased()
        }
    }
    
    convenience init(localization: Localization? = nil, departure: Departure) {
        self.init(frame: .zero)
        self.localization = localization
        self.departure = departure
    }
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: timeView.intrinsicContentSize.width + 44.0, height: timeView.intrinsicContentSize.height)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: max(newValue.size.width, intrinsicContentSize.width), height: max(newValue.size.height, intrinsicContentSize.height))
        }
        get {
            return super.frame
        }
    }
    
    override func setUp() {
        super.setUp()
        
        contentView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin]
        contentView.frame.size = intrinsicContentSize
        contentView.frame.origin.x = bounds.size.width - contentView.frame.size.width
        addSubview(contentView)
        
        timeView.frame.origin.x = contentView.bounds.size.width - timeView.frame.size.width
        contentView.addSubview(timeView)
        
        iconView.isHidden = true
        iconView.frame.origin.y = contentView.bounds.size.height - iconView.frame.size.height
        contentView.addSubview(iconView)
        
        statusLabel.font = .systemFont(ofSize: 9.0, weight: .bold)
        statusLabel.textAlignment = .center
        statusLabel.text = ""
        statusLabel.frame.size.width = iconView.frame.size.width
        statusLabel.frame.size.height = iconView.frame.origin.y
        contentView.addSubview(statusLabel)
        
        transitionMode(duration: 0.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        setUp()
    }
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        timeView.transitionMode(duration: duration)
        iconView.transitionMode(duration: duration)
        
        UIView.animate(withDuration: duration) {
            self.statusLabel.textColor = .text
        }
    }
}
