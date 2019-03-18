import UIKit
import BoatsKit
import BoatsBot

class TimetableView: UIView {
    private(set) var complication: Complication!
    
    var isHighlighted: Bool {
        set {
            departureView.isHighlighted = newValue
            setNeedsLayout()
            layoutIfNeeded()
        }
        get {
            return departureView.isHighlighted
        }
    }
    
    required init(complication: Complication) {
        super.init(frame: .zero)
        
        self.complication = complication
        
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor.color.cgColor
        contentView.layer.cornerRadius = .cornerRadius
        contentView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        contentView.frame.size.height = intrinsicContentSize.height - (.edgeInset * 2.0)
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        addSubview(contentView)
        
        background.location.autoresizingMask = [.flexibleWidth]
        background.location.frame.size.width = contentView.bounds.size.width
        background.location.frame.size.height = 39.0
        contentView.addSubview(background.location)
        
        locationLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        locationLabel.text = "Depart \(complication.origin.abbreviated)"
        locationLabel.frame.origin.x = .edgeInset
        locationLabel.frame.origin.y = 2.0
        locationLabel.frame.size.height = background.location.bounds.size.height - locationLabel.frame.origin.y
        background.location.addSubview(locationLabel)
        
        separator.horizontal.backgroundColor = .color
        separator.horizontal.autoresizingMask = [.flexibleWidth]
        separator.horizontal.frame.size.width = contentView.bounds.size.width
        separator.horizontal.frame.size.height = .borderWidth
        separator.horizontal.frame.origin.y = locationLabel.frame.origin.y + locationLabel.frame.size.height
        contentView.addSubview(separator.horizontal)
        
        separator.vertical.backgroundColor = separator.horizontal.backgroundColor
        separator.vertical.frame.origin.y = separator.horizontal.frame.origin.y + separator.horizontal.frame.size.height
        separator.vertical.frame.size.width = .borderWidth
        separator.vertical.frame.size.height = contentView.bounds.size.height - separator.vertical.frame.origin.y
        contentView.addSubview(separator.vertical)
        
        background.day.frame.size.height = separator.vertical.frame.size.height
        background.day.frame.origin.y = separator.vertical.frame.origin.y
        contentView.addSubview(background.day)
        
        dayLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        dayLabel.text = complication.day.abbreviated
        dayLabel.frame.size.height = background.day.frame.size.height
        dayLabel.frame.origin.x = locationLabel.frame.origin.x
        background.day.addSubview(dayLabel)
        
        departureView.departure = complication.departure
        departureView.frame.size.width = 168.0
        departureView.frame.size.height = separator.vertical.frame.size.height
        departureView.frame.origin.x = .edgeInset
        background.departure.addSubview(departureView)
        
        background.departure.frame.size.width = departureView.frame.size.width + (departureView.frame.origin.x * 2.0)
        background.departure.frame.size.height = departureView.frame.size.height
        background.departure.frame.origin.y = separator.vertical.frame.origin.y
        contentView.addSubview(background.departure)
    }
    
    private let contentView: UIView = UIView()
    private let background: (location: UIView, day: UIView, departure: UIView) = (UIView(), UIView(), UIView())
    private let separator: (horizontal: UIView, vertical: UIView) = (UIView(), UIView())
    private let locationLabel: UILabel = UILabel()
    private let dayLabel: UILabel = UILabel()
    private let departureView: DepartureView = DepartureView()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 110.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.borderWidth = isHighlighted ? 0.0 : .borderWidth
        contentView.frame.size.width = bounds.size.width - (.edgeInset * 2.0)
        contentView.frame.origin.x = .edgeInset
        
        background.location.backgroundColor = isHighlighted ? .color : .clear
        locationLabel.textColor = isHighlighted ? .background : .color
        locationLabel.frame.size.width = background.location.bounds.size.width - (locationLabel.frame.origin.x * 2.0)
        
        background.departure.backgroundColor = background.location.backgroundColor
        background.departure.frame.origin.x = contentView.bounds.size.width - background.departure.frame.size.width
        
        separator.horizontal.isHidden = isHighlighted
        separator.vertical.isHidden = isHighlighted
        separator.vertical.frame.origin.x = background.departure.frame.origin.x - separator.vertical.frame.size.width
        
        background.day.backgroundColor = background.location.backgroundColor
        background.day.frame.size.width = separator.vertical.frame.origin.x
        background.day.frame.origin.x = 0.0
        
        dayLabel.textColor = locationLabel.textColor
        dayLabel.frame.size.width = background.day.bounds.size.width - dayLabel.frame.origin.x
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
