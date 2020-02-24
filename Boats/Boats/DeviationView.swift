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
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let aspectRatio: CGSize = CGSize(width: 1.2, height: 1.0)
    private let contentView: UIView = UIView()
    private let label: UILabel = UILabel()
    
    // MARK: UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let deviation: Deviation = deviation {
            switch deviation {
            case .start:
                contentView.isHidden = deviation.isExpired
            default:
                contentView.isHidden = false
            }
        } else {
            contentView.isHidden = true
        }
        if frame.size.width / frame.size.height > aspectRatio.width {
            contentView.frame.size.height = frame.size.height * 0.9
            contentView.frame.size.width = contentView.frame.size.height * aspectRatio.width
        } else {
            contentView.frame.size.width = frame.size.width * 0.9
            contentView.frame.size.height = contentView.frame.size.width / aspectRatio.width
        }
        contentView.frame.origin.x = (bounds.size.width - contentView.frame.size.width) / 2.0
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 1.9
        contentView.layer.cornerRadius = contentView.bounds.size.height * 0.15
        contentView.backgroundColor = isHighlighted ? .background : .foreground
        
        label.font = .systemFont(ofSize: contentView.bounds.size.height * 0.28, weight: .semibold)
        label.textColor = .label(highlighted: !isHighlighted)
        label.text = deviation?.description.replacingOccurrences(of: " ", with: "\n")
        label.frame = contentView.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerCurve = .continuous
        addSubview(contentView)
        
        label.textAlignment = .center
        label.numberOfLines = 2
        contentView.addSubview(label)
    }
}
