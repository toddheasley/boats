import SwiftUI
import Boats

struct DepartureView: View {
    let departure: Departure
    
    init(_ departure: Departure) {
        self.departure = departure
    }
    
    // MARK: View
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            TimeView(departure.time)
            if departure.isCarFerry {
                Text("cf")
            }
            ForEach(departure.deviations) { deviation in
                Text(deviation.description(.compact))
            }
        }
    }
}

struct DepartureView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        DepartureView(Departure(Time(), deviations: [
            .except(.friday)
        ]))
    }
}

extension Deviation: Identifiable {
    
    // MARK: Identifiable
    public var id: String {
        return description(.compact)
    }
}

/*
class DepartureView: UIView {
    var isHighlighted: Bool {
        set {
            timeView.isHighlighted = newValue
            deviationView.isHighlighted = newValue
            carView.isHighlighted = newValue
            setNeedsLayout()
            layoutIfNeeded()
        }
        get {
            return timeView.isHighlighted
        }
    }
    
    var departure: Departure? {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    convenience init(departure: Departure) {
        self.init(frame: .zero)
        self.departure = departure
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let aspectRatio: CGSize = CGSize(width: 4.56, height: 1.0)
    private let contentView: UIView = UIView()
    private let strikeView: UIView = UIView()
    private let timeView: TimeView = TimeView()
    private let deviationView: DeviationView = DeviationView()
    private let carView: CarView = CarView()
    
    // MARK: UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if frame.size.width / frame.size.height > aspectRatio.width {
            contentView.frame.size.width = frame.size.height * aspectRatio.width
            contentView.frame.size.height = frame.size.height
        } else {
            contentView.frame.size.width = frame.size.width
            contentView.frame.size.height = frame.size.width / aspectRatio.width
        }
        contentView.frame.origin.x = (bounds.size.width - contentView.frame.size.width) / 2.0
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        
        deviationView.frame.size.height = contentView.bounds.size.height
        deviationView.frame.size.width = deviationView.frame.size.height
        deviationView.frame.origin.x = contentView.bounds.size.width - deviationView.frame.size.width
        
        timeView.frame.size.height = deviationView.frame.size.height
        timeView.frame.size.width = deviationView.frame.origin.x
        
        strikeView.frame.size.width = timeView.frame.size.width * 0.9
        strikeView.frame.size.height = max(timeView.frame.size.height * 0.4, 2.0)
        strikeView.frame.origin.x = timeView.frame.origin.x + ((timeView.frame.size.width - strikeView.frame.size.width) / 4.0)
        strikeView.frame.origin.y = timeView.frame.origin.y + ((timeView.frame.size.height - strikeView.frame.size.height) / 1.8)
        
        carView.frame = deviationView.frame
        
        deviationView.deviation = departure?.deviations.first
        carView.isCarFerry = deviationView.deviation == nil && (departure?.isCarFerry ?? false)
        timeView.time = departure?.time
        
        strikeView.isHidden = true
        if let deviation: Deviation = departure?.deviations.first {
            switch deviation {
            case .end:
                strikeView.isHidden = !deviation.isExpired
            default:
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.clipsToBounds = true
        addSubview(contentView)
        
        contentView.addSubview(timeView)
        contentView.addSubview(deviationView)
        contentView.addSubview(carView)
        
        strikeView.isHidden = true
        strikeView.backgroundColor = .foreground
        contentView.addSubview(strikeView)
    }
} */
