import UIKit
import BoatsKit

class TimeView: UIView, ModeTransitioning {
    static let formatter: DateFormatter = DateFormatter()
    
    private let contentView: UIView = UIView()
    private let labels: [UILabel] = [
        UILabel(),
        UILabel(),
        UILabel(),
        UILabel(),
        UILabel(),
        UILabel()
    ]
    
    var localization: Localization? {
        didSet {
            transitionMode(duration: 0.0)
        }
    }
    
    var time: Time? {
        didSet {
            transitionMode(duration: 0.0)
        }
    }
    
    convenience init(localization: Localization? = nil, time: Time) {
        self.init(frame: .zero)
        self.localization = localization
        self.time = time
    }
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 210.0, height: 56.0)
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
        
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleBottomMargin, UIView.AutoresizingMask.flexibleLeftMargin]
        contentView.frame.size = intrinsicContentSize
        contentView.frame.origin.x = (bounds.size.width - intrinsicContentSize.width) / 2.0
        contentView.frame.origin.y = (bounds.size.height - intrinsicContentSize.height) / 2.0
        addSubview(contentView)
        
        var x: CGFloat = 0.0
        for (i, label) in labels.enumerated() {
            label.font = .time
            label.textAlignment = .center
            label.frame.size.width = (intrinsicContentSize.width / 10) * (i != 2 && i != 5 ? 2 : 1)
            label.frame.size.height = intrinsicContentSize.height
            label.frame.origin.x = x
            contentView.addSubview(label)
            x += label.frame.size.width
        }
        
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
        TimeView.formatter.localization = localization ?? Localization()
        
        var components: [(text: String, color: UIColor)] = [
            ("0", .burn),
            ("0", .burn),
            (":", .burn),
            ("0", .burn),
            ("0", .burn),
            (".", .burn)
        ]
        if let time: Time = time {
            for (i, component) in TimeView.formatter.components(from: time).enumerated() {
                guard component != " " else {
                    continue
                }
                components[i] = (component, .text)
            }
        }
        
        UIView.animate(withDuration: duration) {
            for (i, label) in self.labels.enumerated() {
                label.textColor = components[i].color
                label.text = components[i].text
            }
        }
    }
}
