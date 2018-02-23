import UIKit
import BoatsKit

class ScheduleViewCell: UICollectionViewCell, ModeTransitioning {
    private static let cell: ScheduleViewCell = ScheduleViewCell()
    
    static func size(for width: CGFloat) -> CGSize {
        return CGSize(width: width / CGFloat(max(Int(width / cell.intrinsicContentSize.width), 1)), height: cell.intrinsicContentSize.height)
    }
    
    private let departureView: DepartureView = DepartureView()
    
    var localization: Localization? {
        set {
            departureView.localization = newValue
        }
        get {
            return departureView.localization
        }
    }
    
    var departure: Departure? {
        set {
            departureView.departure = newValue
        }
        get {
            return departureView.departure
        }
    }
    
    var status: DepartureView.Status {
        set {
            departureView.status = newValue
        }
        get {
            return departureView.status
        }
    }
    
    // MARK: UICollectionViewCell
    override var intrinsicContentSize: CGSize {
        return CGSize(width: departureView.intrinsicContentSize.width + UIEdgeInsets.padding.size.width, height: departureView.intrinsicContentSize.height + UIEdgeInsets.padding.size.height)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: max(newValue.size.width, intrinsicContentSize.width), height: max(newValue.size.height, intrinsicContentSize.height))
        }
        get {
            return super.frame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame.size.width = bounds.size.width - UIEdgeInsets.padding.size.width
        contentView.frame.size.height = bounds.size.height - UIEdgeInsets.padding.size.height
        contentView.frame.origin.x = UIEdgeInsets.padding.left
        contentView.frame.origin.y = UIEdgeInsets.padding.top
    }
    
    override func setUp() {
        super.setUp()
        
        departureView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        departureView.frame = contentView.bounds
        contentView.addSubview(departureView)
        
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
        departureView.transitionMode(duration: duration)
    }
}
