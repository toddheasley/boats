import UIKit

class MenuButton: UIControl {
    private let imageView: UIImageView = UIImageView(image: .menu)
    
    // MARK: UIControl
    override var isHighlighted: Bool {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 42.0, height: 28.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.tintColor = isHighlighted ? .tint : .color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .center
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
        imageView.frame.size = intrinsicContentSize
        imageView.frame.origin.x = (bounds.size.width - imageView.frame.size.width) / 2.0
        imageView.frame.origin.y = (bounds.size.height - imageView.frame.size.height) / 2.0
        addSubview(imageView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
