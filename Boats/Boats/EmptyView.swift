import UIKit

class EmptyView: UIView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let label: UILabel = UILabel()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 54.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = bounds.size.width
        label.frame.size.height = min(label.sizeThatFits(bounds.size).height, bounds.size.height)
        label.frame.origin.y = (bounds.size.height - label.frame.size.height) / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = .systemFont(ofSize: label.font.pointSize, weight: .semibold)
        label.numberOfLines = 0
        label.text = "Schedule\nUnavailable"
        addSubview(label)
    }
}
