import UIKit
import BoatsKit

class CarView: UIView {
    var isHighlighted: Bool = false {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var isCarFerry: Bool {
        set {
            imageView.isHidden = !newValue
        }
        get {
            return !imageView.isHidden
        }
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = UIImageView(image: .car)
    
    // MARK: UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame.size.width = min(bounds.size.width, bounds.size.height)
        imageView.frame.size.height = imageView.frame.size.width
        imageView.frame.origin.x = (bounds.size.width - imageView.frame.size.width) / 2.0
        imageView.frame.origin.y = ((bounds.size.height - imageView.frame.size.height) / 2.0) + (imageView.frame.size.height * 0.05)
        imageView.tintColor = .label(highlighted: isHighlighted)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
}
