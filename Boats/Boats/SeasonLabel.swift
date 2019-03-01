import UIKit
import BoatsKit

class SeasonLabel: UIView {
    var season: Season? {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    convenience init(season: Season) {
        self.init()
        self.season = season
    }
    
    private let contentView: UIView = UIView()
    private let nameLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return contentView.frame.size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.backgroundColor = .color
        nameLabel.textColor = .background
        nameLabel.text = season?.name.description
        nameLabel.frame.size.width = nameLabel.sizeThatFits(.zero).width + (.edgeInset * 2.0)
        
        dateLabel.backgroundColor = nameLabel.backgroundColor
        dateLabel.textColor = nameLabel.textColor
        dateLabel.text = season?.description.components(separatedBy: ": ").last
        dateLabel.frame.size.width = dateLabel.sizeThatFits(.zero).width + (.edgeInset * 2.0)
        dateLabel.frame.origin.x = nameLabel.frame.size.width + .borderWidth
        
        contentView.frame.size.width = dateLabel.frame.origin.x + dateLabel.frame.size.width
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        contentView.isHidden = season == nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = .cornerRadius / 3.0
        contentView.frame.size.height = 25.0
        addSubview(contentView)
        
        nameLabel.font = .systemFont(ofSize: 15.0, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.frame.size.height = contentView.bounds.size.height
        contentView.addSubview(nameLabel)
        
        dateLabel.font = .systemFont(ofSize: 15.0, weight: .semibold)
        dateLabel.textAlignment = .center
        dateLabel.frame.size.height = contentView.bounds.size.height
        contentView.addSubview(dateLabel)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
