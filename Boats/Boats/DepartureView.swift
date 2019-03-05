import UIKit
import BoatsKit

class DepartureView: UIView {
    var isHighlighted: Bool {
        set {
            timeView.isHighlighted = newValue
            deviationView.isHighlighted = newValue
            updateAppearance()
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
    
    private let aspectRatio: CGSize = CGSize(width: 4.56, height: 1.0)
    private let contentView: UIView = UIView()
    private let timeView: TimeView = TimeView()
    private let deviationView: DeviationView = DeviationView()
    private let carView: CarView = CarView()
    
    // MARK: UIView
    override func updateAppearance() {
        super.updateAppearance()
        
        carView.tintColor = isHighlighted ? .background : .color
    }
    
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
        
        carView.frame = deviationView.frame
        
        deviationView.deviation = departure?.deviations.first
        carView.isCarFerry = deviationView.deviation == nil && (departure?.isCarFerry ?? false)
        timeView.time = departure?.time
        updateAppearance()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.clipsToBounds = true
        addSubview(contentView)
        
        contentView.addSubview(timeView)
        contentView.addSubview(deviationView)
        contentView.addSubview(carView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
