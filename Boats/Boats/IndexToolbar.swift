import UIKit
import BoatsKit

class IndexToolbar: Toolbar {
    private let nameLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    
    var index: Index? {
        didSet {
            layoutSubviews()
        }
    }
    
    convenience init(index: Index) {
        self.init(frame: .zero)
        self.index = index
    }
    
    // MARK: Toolbar
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 61.0 + UIEdgeInsets.padding.size.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.text = index?.name
        descriptionLabel.text = index?.description
    }
    
    override func setUp() {
        super.setUp()
        
        separatorPosition = .bottom
        
        nameLabel.font = UIFont.systemFont(ofSize: 34.0, weight: .bold)
        nameLabel.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        nameLabel.frame.size.width = contentView.bounds.size.width
        nameLabel.frame.size.height = 44.0
        nameLabel.frame.origin.y = contentView.bounds.size.height - nameLabel.frame.size.height
        contentView.addSubview(nameLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        descriptionLabel.autoresizingMask = [.flexibleWidth]
        descriptionLabel.frame.size.width = contentView.bounds.size.width
        descriptionLabel.frame.size.height = 22.0
        contentView.addSubview(descriptionLabel)
        
        transitionMode(duration: 0.0)
    }
    
    override func transitionMode(duration: TimeInterval) {
        super.transitionMode(duration: duration)
        
        UIView.animate(withDuration: duration) {
            self.nameLabel.textColor = .text
            self.descriptionLabel.textColor = .text
        }
    }
}
