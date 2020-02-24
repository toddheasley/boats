import UIKit

class ListControl: NavigationControl {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = UIImageView(image: .list)
    
    // MARK: NavigationControl
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 31.0, height: 44.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .center
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22.0, weight: .bold, scale: .default)
        imageView.tintColor = .label
        imageView.frame.size = intrinsicContentSize
        imageView.frame.origin.y = 1.5
        contentView.addSubview(imageView)
    }
}
