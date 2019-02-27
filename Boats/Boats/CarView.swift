import UIKit
import BoatsKit

class CarView: UIView {
    var isCarFerry: Bool = false {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    private let imageView: UIImageView = UIImageView(image: .car)
    
    // MARK: UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.isHidden = !isCarFerry
        imageView.tintColor = .color
        imageView.frame.size.width = bounds.size.width * 0.9
        imageView.frame.size.height = bounds.size.height * 0.9
        imageView.frame.origin.x = (bounds.size.width - imageView.frame.size.width) / 2.0
        imageView.frame.origin.y = (bounds.size.height - imageView.frame.size.height) / 2.0
        
        accessibilityLabel = isCarFerry ? "car ferry" : nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
