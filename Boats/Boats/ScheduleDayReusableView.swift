import UIKit
import BoatsKit

class ScheduleDayReusableView: UICollectionReusableView, ModeTransitioning {
    private static let view: ScheduleDayReusableView = ScheduleDayReusableView()
    
    static func size(for width: CGFloat) -> CGSize {
        return CGSize(width: width, height: view.intrinsicContentSize.height)
    }
    
    private let label: UILabel = UILabel()
    
    var day: Day? {
        didSet {
            label.text = day?.rawValue.capitalized
        }
    }
    
    // MARK: UICollectionReusableView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: label.frame.size.height + UIEdgeInsets.padding.height)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: newValue.size.width, height: max(newValue.size.height, intrinsicContentSize.height))
        }
        get {
            return super.frame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = bounds.size.width - UIEdgeInsets.padding.width
    }
    
    override func setUp() {
        super.setUp()
        
        label.font = .base(.bold)
        label.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        label.frame.size.height = 22.0
        label.frame.origin.y = (bounds.size.height - label.frame.size.height) / 2.0
        label.frame.origin.x = UIEdgeInsets.padding.left
        addSubview(label)
        
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
        UIView.animate(withDuration: duration) {
            self.label.textColor = .text
        }
    }
}
