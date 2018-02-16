import UIKit
import BoatsKit

class IndexView: UIView, ModeTransitioning {
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
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 0.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.text = index?.name
        descriptionLabel.text = index?.description
    }
    
    override func setUp() {
        super.setUp()
        
        backgroundColor = .clear
        
        //nameLabel.font = .systemFont(ofSize: 24.0, weight: .bold)
        nameLabel.autoresizingMask = [.flexibleWidth]
        nameLabel.frame.size.width = bounds.size.width
        nameLabel.frame.origin.x = 10.0
        nameLabel.frame.origin.y = 10.0
        addSubview(nameLabel)
        
        //descriptionLabel.font = .systemFont(ofSize: 24.0, weight: .regular)
        descriptionLabel.autoresizingMask = [.flexibleWidth]
        descriptionLabel.frame.size.width = bounds.size.width
        descriptionLabel.frame.origin.x = 10.0
        descriptionLabel.frame.origin.y = 40.0
        addSubview(descriptionLabel)
        
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
            self.nameLabel.textColor = .text
            self.descriptionLabel.textColor = .text
        }
    }
}
