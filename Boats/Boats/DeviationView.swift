import UIKit
import BoatsKit

class DeviationView: UIView {
    var isHighlighted: Bool = false {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var deviation: Deviation? {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    convenience init(deviation: Deviation) {
        self.init(frame: .zero)
        self.deviation = deviation
    }
    
    private let aspectRatio: CGSize = CGSize(width: 1.2, height: 1.0)
    private let contentView: UIView = UIView()
    private let label: UILabel = UILabel()
    
    // MARK: UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.isHidden = deviation == nil
        if frame.size.width / frame.size.height > aspectRatio.width {
            contentView.frame.size.height = frame.size.height * 0.9
            contentView.frame.size.width = contentView.frame.size.height * aspectRatio.width
        } else {
            contentView.frame.size.width = frame.size.width * 0.9
            contentView.frame.size.height = contentView.frame.size.width / aspectRatio.width
        }
        contentView.frame.origin.x = (bounds.size.width - contentView.frame.size.width) / 2.0
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 1.9
        contentView.layer.cornerRadius = contentView.frame.size.width * 0.1
        
        label.font = .systemFont(ofSize: contentView.bounds.size.height * 0.33)
        label.frame = contentView.bounds
        
        contentView.backgroundColor = isHighlighted ? .background : .color
        label.textColor = isHighlighted ? .color : .background
        label.text = deviation?.description
        
        accessibilityLabel = deviation?.description
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        addSubview(contentView)
        
        label.textAlignment = .center
        label.numberOfLines = 2
        contentView.addSubview(label)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
