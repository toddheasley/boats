import UIKit
import BoatsKit

class TimetableView: UIView {
    private(set) var timetable: Timetable!
    private(set) var origin: Location!
    private(set) var destination: Location!
    
    var contentOffset: CGPoint = .zero {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    @discardableResult func highlight(time: Time = Time()) -> CGRect? {
        clearHighlighted()
        for subview in contentView.subviews {
            guard let tripView: TripView = subview as? TripView else {
                continue
            }
            if let departure: Departure = tripView.trip?.origin, departure.time > time {
                tripView.isHighlighted.origin = true
                return tripView.frame
            } else if let departure: Departure = tripView.trip?.destination, departure.time > time {
                tripView.isHighlighted.destination = true
                return tripView.frame
            }
        }
        return nil
    }
    
    func clearHighlighted() {
        for subview in contentView.subviews {
            (subview as? TripView)?.isHighlighted = (false, false)
        }
    }
    
    required init(timetable: Timetable, origin: Location, destination: Location) {
        super.init(frame: .zero)
        
        self.timetable = timetable
        self.origin = origin
        self.destination = destination
        
        backgroundColor = .background
        
        contentView.clipsToBounds = true
        contentView.backgroundColor = .foreground
        contentView.autoresizingMask = [.flexibleWidth]
        contentView.frame.size.width = bounds.size.width
        contentView.layer.cornerCurve = .continuous
        contentView.layer.cornerRadius = 19.0
        contentView.layer.borderWidth = 2.0
        addSubview(contentView)
        
        headerView.clipsToBounds = true
        headerView.backgroundColor = .background
        headerView.autoresizingMask = [.flexibleWidth]
        headerView.frame.size.width = bounds.size.width
        addSubview(headerView)
        
        headerContentView.clipsToBounds = true
        headerContentView.backgroundColor = .foreground
        headerContentView.layer.cornerCurve = contentView.layer.cornerCurve
        headerContentView.layer.cornerRadius = contentView.layer.cornerRadius
        headerContentView.layer.borderWidth = contentView.layer.borderWidth
        headerView.addSubview(headerContentView)
        
        descriptionView.text = timetable.description
        descriptionView.frame.origin.y = contentView.layer.borderWidth
        descriptionView.frame.size.height = 42.0
        headerContentView.addSubview(descriptionView)
        
        directionView.text.origin = "Depart \(origin.abbreviated)"
        directionView.text.destination = "Depart \(destination.abbreviated)"
        directionView.frame.origin.y = (descriptionView.frame.origin.y + descriptionView.frame.size.height) + contentView.layer.borderWidth
        directionView.frame.size.height = 27.0
        headerContentView.addSubview(directionView)
        
        for trip in timetable.trips {
            contentView.addSubview(TripView(trip: trip))
        }
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let contentView: UIView = UIView()
    private let headerView: UIView = UIView()
    private let headerContentView: UIView = UIView()
    private let descriptionView: DescriptionView = DescriptionView()
    private let directionView: DirectionView = DirectionView()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return contentView.bounds.size
    }
    
    override var frame: CGRect {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height: CGFloat = directionView.frame.origin.y + directionView.frame.size.height + contentView.layer.borderWidth
        for (index, subview) in contentView.subviews.enumerated() {
            guard let subview: TripView = subview as? TripView else {
                continue
            }
            subview.frame.size.width = contentView.bounds.size.width
            subview.frame.size.height = subview.intrinsicContentSize.height
            subview.frame.origin.y = height + ((subview.frame.size.height + contentView.layer.borderWidth) * CGFloat(index))
        }
        if let last: CGRect = contentView.subviews.last?.frame {
            contentView.frame.size.height = last.origin.y + last.size.height + contentView.layer.borderWidth
        }
        contentView.frame.origin.x = (bounds.size.width - contentView.frame.size.width) / 2.0
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        contentView.layer.borderColor = UIColor.foreground.cgColor
        contentView.isHidden = timetable == nil
        
        let a: CGFloat = contentView.frame.origin.y + height + max(contentOffset.y - frame.origin.y, 0.0)
        let b: CGFloat = (contentView.frame.origin.y + contentView.frame.size.height) - (contentView.subviews.last?.frame.size.height ?? (contentView.layer.cornerRadius * 2.0))
        headerView.frame.size.height = min(a, b)
        headerView.frame.origin.y = 0.0
        headerView.isHidden = contentView.isHidden
        
        headerContentView.frame.size = contentView.frame.size
        headerContentView.frame.origin.x = contentView.frame.origin.x
        headerContentView.frame.origin.y = headerView.frame.size.height - height
        headerContentView.layer.borderColor = contentView.layer.borderColor
        
        descriptionView.frame.size.width = contentView.bounds.size.width
        directionView.frame.size.width = contentView.bounds.size.width
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}

fileprivate class DescriptionView: UIView {
    var text: String? {
        set {
            label.text = newValue
        }
        get {
            return label.text
        }
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let label: UILabel = UILabel()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return label.sizeThatFits(.zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = bounds.size.width - (label.frame.origin.x * 2.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .background(highlighted: true)
        
        label.font = .systemFont(ofSize: 21.0, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.autoresizingMask = [.flexibleHeight]
        label.frame.size.height = bounds.size.height
        label.frame.origin.x = 9.0
        addSubview(label)
    }
}

fileprivate class DirectionView: UIView {
    var text: (origin: String?, destination: String?) {
        set {
            originLabel.text = newValue.origin
            destinationLabel.text = newValue.destination
        }
        get {
            return (originLabel.text, destinationLabel.text)
        }
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let contentView: (origin: UIView, destination: UIView) = (UIView(), UIView())
    private let originLabel: UILabel = UILabel()
    private let destinationLabel: UILabel = UILabel()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: originLabel.sizeThatFits(.zero).width + destinationLabel.sizeThatFits(.zero).width, height: originLabel.sizeThatFits(.zero).height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.origin.frame.size.width = (bounds.size.width / 2.0) - 1.0
        contentView.origin.frame.size.height = bounds.size.height
        contentView.destination.frame.size = contentView.origin.frame.size
        contentView.destination.frame.origin.x = bounds.size.width - contentView.destination.frame.size.width
        
        originLabel.frame.size.width = contentView.origin.bounds.size.width - (originLabel.frame.origin.x * 1.5)
        destinationLabel.frame.size.width = originLabel.frame.size.width
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.origin.backgroundColor = .background(highlighted: true)
        addSubview(contentView.origin)
        contentView.destination.backgroundColor = contentView.origin.backgroundColor
        addSubview(contentView.destination)
        
        originLabel.font = .systemFont(ofSize: 15.0, weight: .bold)
        originLabel.textColor = .label
        originLabel.autoresizingMask = [.flexibleHeight]
        originLabel.frame.size.height = contentView.origin.bounds.size.height
        originLabel.frame.origin.x = 9.0
        contentView.origin.addSubview(originLabel)
        
        destinationLabel.font = originLabel.font
        destinationLabel.textColor = .label
        destinationLabel.autoresizingMask = [.flexibleHeight]
        destinationLabel.frame.size.height = contentView.destination.bounds.size.height
        destinationLabel.frame.origin.x = originLabel.frame.origin.x
        contentView.destination.addSubview(destinationLabel)
    }
}

fileprivate class TripView: UIView {
    private(set) var trip: Timetable.Trip?
    
    var isHighlighted: (origin: Bool, destination: Bool) {
        set {
            originView.isHighlighted = newValue.origin
            destinationView.isHighlighted = newValue.destination
            setNeedsLayout()
            layoutIfNeeded()
        }
        get {
            return (originView.isHighlighted, destinationView.isHighlighted)
        }
    }
    
    convenience init(trip: Timetable.Trip) {
        self.init(frame: .zero)
        self.trip = trip
        
        originView.departure = trip.origin
        destinationView.departure = trip.destination
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let contentView: (origin: UIView, destination: UIView) = (UIView(), UIView())
    private let originView: DepartureView = DepartureView()
    private let destinationView: DepartureView = DepartureView()
    private let aspectRatio: CGSize = CGSize(width: 7.2, height: 1.0)
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.size.width, height: frame.size.width / aspectRatio.width)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.origin.frame.size.width = (bounds.size.width / 2.0) - 1.0
        contentView.origin.frame.size.height = bounds.size.height
        contentView.destination.frame.size = contentView.origin.frame.size
        contentView.destination.frame.origin.x = bounds.size.width - contentView.destination.frame.size.width
        
        originView.frame.origin.x = 8.0
        originView.frame.size.width = contentView.origin.frame.size.width - (originView.frame.origin.x * 2.0)
        originView.frame.size.height = contentView.origin.frame.size.height
        destinationView.frame = originView.frame
        
        contentView.origin.backgroundColor = (originView.departure != nil && isHighlighted.origin) ? nil : .background(highlighted: true)
        contentView.destination.backgroundColor = (destinationView.departure != nil && isHighlighted.destination) ? nil : .background(highlighted: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView.origin)
        addSubview(contentView.destination)
        
        contentView.origin.addSubview(originView)
        contentView.destination.addSubview(destinationView)
    }
}
