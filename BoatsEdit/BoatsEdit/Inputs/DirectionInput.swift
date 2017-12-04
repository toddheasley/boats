//
// © 2018 @toddheasley
//

import Cocoa
import BoatsKit

class DirectionInput: Input {
    private let segmentedControl: NSSegmentedControl = NSSegmentedControl()
    
    var direction: Departure.Direction {
        set {
            segmentedControl.selectedSegment = newValue == .destination ? 1 : 0
        }
        get {
            return segmentedControl.selectedSegment == 0 ? .origin : .destination
        }
    }
    
    // MARK: Input
    override func setUp() {
        super.setUp()
        
        segmentedControl.target = self
        segmentedControl.action = #selector(inputEdited(_:))
        segmentedControl.segmentCount = 2
        segmentedControl.setLabel(Departure.Direction.origin.rawValue.capitalized, forSegment: 0)
        segmentedControl.setWidth(117.0, forSegment: 0)
        segmentedControl.setLabel(Departure.Direction.destination.rawValue.capitalized, forSegment: 1)
        segmentedControl.setWidth(117.0, forSegment: 1)
        segmentedControl.frame.size.width = 240.0
        segmentedControl.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + segmentedControl.frame.size.width)
        segmentedControl.frame.origin.y = contentInsets.bottom
        addSubview(segmentedControl)
        
        label = "Direction"
        direction = .destination
    }
}
