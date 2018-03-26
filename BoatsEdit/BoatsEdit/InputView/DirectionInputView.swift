import Cocoa
import BoatsKit

class DirectionInputView: InputView {
    private let segmentedControl: NSSegmentedControl = NSSegmentedControl()
    
    var direction: Departure.Direction {
        set {
            segmentedControl.selectedSegment = newValue == .destination ? 1 : 0
        }
        get {
            return segmentedControl.selectedSegment == 0 ? .origin : .destination
        }
    }
    
    @objc func handleDirection(_ sender: AnyObject?) {
        delegate?.inputViewDidEdit(self)
    }
    
    // MARK: InputView
    override func setUp() {
        super.setUp()
        
        contentView.frame.size.height = 22.0
        
        segmentedControl.target = self
        segmentedControl.action = #selector(handleDirection(_:))
        segmentedControl.segmentCount = 2
        segmentedControl.setLabel(Departure.Direction.origin.rawValue.capitalized, forSegment: 0)
        segmentedControl.setWidth(117.0, forSegment: 0)
        segmentedControl.setLabel(Departure.Direction.destination.rawValue.capitalized, forSegment: 1)
        segmentedControl.setWidth(117.0, forSegment: 1)
        segmentedControl.frame.size.width = 240.0
        segmentedControl.frame.origin.x = contentView.bounds.size.width - segmentedControl.frame.size.width + 2.0
        segmentedControl.frame.origin.y = -2.0
        contentView.addSubview(segmentedControl)
        
        label = "Direction"
        direction = .destination
    }
}
