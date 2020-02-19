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
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let contentView: UIView = UIView()
    private let nameLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: !contentView.isHidden ? contentView.bounds.size.width : 0.0, height: contentView.bounds.size.height)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.text = season?.name.description
        nameLabel.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .background(highlighted: true) : .foreground
        nameLabel.frame.size.width = nameLabel.sizeThatFits(.zero).width + 19.0
        
        dateLabel.text = season?.description.components(separatedBy: ": ").last
        dateLabel.backgroundColor = nameLabel.backgroundColor
        dateLabel.frame.size.width = dateLabel.sizeThatFits(.zero).width + 19.0
        dateLabel.frame.origin.x = nameLabel.frame.size.width + 2.0
        
        contentView.frame.size.width = dateLabel.frame.origin.x + dateLabel.frame.size.width
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        contentView.isHidden = season == nil
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerCurve = .continuous
        contentView.layer.cornerRadius = 9.5
        contentView.frame.size.height = 27.0
        addSubview(contentView)
        
        nameLabel.font = .systemFont(ofSize: 15.0, weight: .bold)
        nameLabel.textColor = .label(highlighted: true)
        nameLabel.textAlignment = .center
        nameLabel.frame.size.height = contentView.bounds.size.height
        contentView.addSubview(nameLabel)
        
        dateLabel.font = .systemFont(ofSize: 15.0, weight: .semibold)
        dateLabel.textColor = .label(highlighted: true)
        dateLabel.textAlignment = .center
        dateLabel.frame.size.height = contentView.bounds.size.height
        contentView.addSubview(dateLabel)
    }
}
