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
        return CGSize(width: super.intrinsicContentSize.width, height: 62.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.text = index?.name
        descriptionLabel.text = index?.description
    }
    
    override func setUp() {
        super.setUp()
        
        separatorPosition = .bottom
        
        nameLabel.font = UIFont.systemFont(ofSize: 19.0, weight: .bold)
        nameLabel.autoresizingMask = [.flexibleWidth]
        nameLabel.frame.size.width = contentView.bounds.size.width
        nameLabel.frame.size.height = 21.0
        contentView.addSubview(nameLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: .base, weight: .regular)
        descriptionLabel.autoresizingMask = [.flexibleWidth]
        descriptionLabel.frame.size.width = contentView.bounds.size.width
        descriptionLabel.frame.size.height = 19.0
        descriptionLabel.frame.origin.y = nameLabel.frame.size.height
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
