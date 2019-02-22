import UIKit
import BoatsKit

class TimetableView: UIView {
    var timetable: Timetable? {
        didSet {
            contentView.removeSubviews()
            descriptionView.text = timetable?.description
            contentView.addSubview(descriptionView)
            for trip in timetable?.trips ?? [] {
                contentView.addSubview(TripView(trip: trip))
            }
            layout()
        }
    }
    
    convenience init(timetable: Timetable) {
        self.init(frame: .zero)
        self.timetable = timetable
    }
    
    private let contentView: UIView = UIView()
    private let descriptionView: DescriptionView = DescriptionView()
    
    // MARK: UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .color
        contentView.layer.borderColor = contentView.backgroundColor?.cgColor
        contentView.frame.size.width = bounds.size.width - 20.0
        
        descriptionView.backgroundColor = .background
        descriptionView.frame.size.width = contentView.bounds.size.width
        for (index, subview) in contentView.subviews.enumerated() {
            guard let subview: TripView = subview as? TripView else {
                continue
            }
            subview.frame.size.width = contentView.bounds.size.width
            subview.frame.size.height = subview.intrinsicContentSize.height
            subview.frame.origin.y = (descriptionView.frame.origin.y + descriptionView.frame.size.height) + 1.0 + ((subview.frame.size.height + contentView.layer.borderWidth) * CGFloat(index - 1))
        }
        if let last: CGRect = contentView.subviews.last?.frame {
            contentView.frame.size.height = last.origin.y + last.size.height + contentView.layer.borderWidth
        }
        contentView.frame.origin.x = (bounds.size.width - contentView.frame.size.width) / 2.0
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        contentView.isHidden = timetable == nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 2.0
        contentView.layer.cornerRadius = 12.0
        addSubview(contentView)
        
        descriptionView.frame.origin.y = contentView.layer.borderWidth
        descriptionView.frame.size.height = 44.0
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private let label: UILabel = UILabel()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return label.sizeThatFits(CGSize(width: 1000.0, height: 100.0))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = bounds.size.width - (label.frame.origin.x * 2.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.numberOfLines = 1
        label.autoresizingMask = [.flexibleHeight]
        label.frame.size.height = bounds.size.height
        label.frame.origin.x = 8.0
        addSubview(label)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate class DirectionView: UIView {
    
}

fileprivate class TripView: UIView {
    private(set) var trip: Timetable.Trip?
    
    convenience init(trip: Timetable.Trip) {
        self.init(frame: .zero)
        self.trip = trip
        
        originView.departure = trip.origin
        destinationView.departure = trip.destination
    }
    
    private let contentView: (origin: UIView, destination: UIView) = (UIView(), UIView())
    private let originView: DepartureView = DepartureView()
    private let destinationView: DepartureView = DepartureView()
    private let aspectRatio: CGSize = CGSize(width: 7.2 , height: 1.0)
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.size.width, height: frame.size.width / aspectRatio.width)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.origin.backgroundColor = .background
        contentView.origin.frame.size.width = (bounds.size.width / 2.0) - 1.0
        contentView.origin.frame.size.height = bounds.size.height
        
        contentView.destination.backgroundColor = contentView.origin.backgroundColor
        contentView.destination.frame.size = contentView.origin.frame.size
        contentView.destination.frame.origin.x = bounds.size.width - contentView.destination.frame.size.width
        
        originView.frame.origin.x = 8.0
        originView.frame.size.width = contentView.origin.frame.size.width - (originView.frame.origin.x * 2.0)
        originView.frame.size.height = contentView.origin.frame.size.height - (originView.frame.origin.y * 2.0)
        destinationView.frame = originView.frame
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView.origin)
        addSubview(contentView.destination)
        
        contentView.origin.addSubview(originView)
        contentView.destination.addSubview(destinationView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
