import UIKit
import NotificationCenter
import BoatsKit
import BoatsBot

class TodayView: UIView {
    var index: Index = Index() {
        didSet {
            if let complication: Complication = index.complications(limit: 1, filter: true).first {
                departureView.departure = complication.departure
                dayLabel.text = complication.day.abbreviated
                locationLabel.text = "Depart \(complication.origin.abbreviated) to \(complication.destination.abbreviated)"
                contentView.isHidden = false
            } else {
                contentView.isHidden = true
                departureView.departure = nil
                dayLabel.text = nil
                locationLabel.text = nil
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let contentView: UIView = UIView()
    private let departureBackground: UIView = UIView()
    private let departureView: DepartureView = DepartureView()
    private let dayBackground: UIView = UIView()
    private let dayLabel: UILabel = UILabel()
    private let locationBackground: UIView = UIView()
    private let locationLabel: UILabel = UILabel()
    
    // MARK: UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        departureView.frame.size.width = departureBackground.bounds.size.width - (departureView.frame.origin.x * 2.0)
        
        dayBackground.frame.size.width = departureBackground.frame.origin.x - 2.0
        dayLabel.frame.size.width = dayBackground.bounds.size.width - (dayLabel.frame.origin.x * 2.0)
        dayLabel.textColor = .label(highlighted: true)
        
        locationLabel.textColor = dayLabel.textColor
        locationLabel.frame.size.width = locationBackground.bounds.size.width - (locationLabel.frame.origin.x * 2.0)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.isHidden = true
        contentView.clipsToBounds = true
        contentView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        contentView.frame.size.width = bounds.size.width
        contentView.frame.size.height = 95.0
        contentView.frame.origin.y = bounds.size.height - contentView.frame.size.height
        contentView.layer.cornerCurve = .continuous
        contentView.layer.cornerRadius = 11.0
        contentView.alpha = 0.9
        addSubview(contentView)
        
        departureBackground.backgroundColor = .foreground
        departureBackground.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin]
        departureBackground.frame.size.width = 186.0
        departureBackground.frame.size.height = 54.0
        departureBackground.frame.origin.x = contentView.bounds.size.width - departureBackground.frame.size.width
        departureBackground.frame.origin.y = contentView.bounds.size.height - departureBackground.frame.size.height
        contentView.addSubview(departureBackground)
        
        departureView.isHighlighted = true
        departureView.frame.size.height = departureBackground.bounds.size.height - 2.0
        departureView.frame.origin.x = 11.0
        departureBackground.addSubview(departureView)
        
        dayBackground.backgroundColor = departureBackground.backgroundColor
        dayBackground.autoresizingMask = [.flexibleTopMargin]
        dayBackground.frame.size.height = departureBackground.frame.size.height
        dayBackground.frame.origin.y = departureBackground.frame.origin.y
        contentView.addSubview(dayBackground)
        
        dayLabel.font = .systemFont(ofSize: 39.0, weight: .bold)
        dayLabel.frame.size.height = departureView.frame.size.height
        dayLabel.frame.origin.x = departureView.frame.origin.x
        dayBackground.addSubview(dayLabel)
        
        locationBackground.backgroundColor = departureBackground.backgroundColor
        locationBackground.autoresizingMask = [.flexibleWidth]
        locationBackground.frame.size.width = contentView.bounds.size.width
        locationBackground.frame.size.height = 39.5
        contentView.addSubview(locationBackground)
        
        locationLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        locationLabel.frame.origin.y = 2.0
        locationLabel.frame.size.height = locationBackground.bounds.size.height - locationLabel.frame.origin.y
        locationLabel.frame.origin.x = dayLabel.frame.origin.x
        locationBackground.addSubview(locationLabel)
    }
}
