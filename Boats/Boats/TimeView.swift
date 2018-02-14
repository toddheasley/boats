import UIKit
import BoatsKit

class TimeView: UIView, ModeTransitioning {
    private static let formatter: DateFormatter = DateFormatter()
    private let contentView: UIView = UIView()
    private let labels: [UILabel] = [
        UILabel(),
        UILabel(),
        UILabel(),
        UILabel(),
        UILabel(),
        UILabel()
    ]
    
    var localization: Localization = Localization() {
        didSet {
            transitionMode(duration: 0.0)
        }
    }
    
    var time: Time? {
        didSet {
            transitionMode(duration: 0.0)
        }
    }
    
    convenience init(localization: Localization = Localization(), time: Time) {
        self.init(frame: .zero)
        self.localization = localization
        self.time = time
    }
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 231.0, height: 56.0)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: max(newValue.size.width, intrinsicContentSize.width), height: max(newValue.size.height, intrinsicContentSize.height))
        }
        get {
            return super.frame
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor.red.withAlphaComponent(0.15)
        contentView.layer.borderColor = UIColor.red.withAlphaComponent(0.3).cgColor
        contentView.layer.borderWidth = 1.0
        for label in labels {
            label.layer.borderColor = contentView.layer.borderColor
            label.layer.borderWidth = contentView.layer.borderWidth
        }
    }
    
    override func setUp() {
        super.setUp()
        
        contentView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
        contentView.frame.size = intrinsicContentSize
        contentView.frame.origin.x = (bounds.size.width - intrinsicContentSize.width) / 2.0
        contentView.frame.origin.y = (bounds.size.height - intrinsicContentSize.height) / 2.0
        addSubview(contentView)
        
        var x: CGFloat = intrinsicContentSize.width / 11
        for (index, label) in labels.enumerated() {
            label.font = UIFont.systemFont(ofSize: 64.0, weight: .medium)
            label.textAlignment = .center
            label.frame.size.width = (intrinsicContentSize.width / 11) * (index != 2 && index != 5 ? 2 : 1)
            label.frame.size.height = intrinsicContentSize.height
            label.frame.origin.x = x
            label.frame.origin.y = index == 2 || index == 5 ? 0.0 : 0.0
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
        TimeView.formatter.localization = localization
        
        UIView.animate(withDuration: duration) {
            for (index, label) in self.labels.enumerated() {
                
            }
        }
    }
}
