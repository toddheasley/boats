//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class DepartureInputGroup: InputGroup {
    private let dividerInput: [DividerInput] = [DividerInput(), DividerInput(), DividerInput(style: .none)]
    private let directionInput: DirectionInput = DirectionInput()
    private let timeInput: TimeInput = TimeInput()
    private let dayInput: DayInput = DayInput()
    private let serviceInput: ServiceInput = ServiceInput()
    
    var departure: Departure? {
        set {
            directionInput.direction = newValue?.direction ?? .destination
            timeInput.time = newValue?.time
            dayInput.days = newValue?.days ?? []
            serviceInput.services = newValue?.services ?? []
            tableView.reloadData()
            isHidden = newValue == nil
        }
        get {
            var departure: Departure = Departure()
            departure.direction = directionInput.direction
            departure.time = timeInput.time ?? Time()
            departure.days = dayInput.days
            departure.services = serviceInput.services
            return departure
        }
    }
    
    override var localization: Localization? {
        didSet {
            timeInput.timeZone = localization?.timeZone
            tableView.reloadData()
        }
    }
    
    override var deleteLabel: String? {
        guard let time = departure?.time else {
            return "departure"
        }
        return "\(DateFormatter(localization: localization ?? Localization()).string(from: time)) departure"
    }
    
    override func setUp() {
        super.setUp()
        
        headerInput.label = "Departure"
        headerInput.deleteButton.isHidden = false
        directionInput.delegate = self
        timeInput.delegate = self
        dayInput.delegate = self
        serviceInput.delegate = self
        
        departure = nil
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 8
    }
    
    // MARK: NSTableViewDelegate
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        switch row {
        case 0:
            return headerInput.intrinsicContentSize.height
        case 1:
            return directionInput.intrinsicContentSize.height
        case 2:
            return timeInput.intrinsicContentSize.height
        case 3, 5:
            return dividerInput[0].intrinsicContentSize.height
        case 4:
            return dayInput.intrinsicContentSize.height
        case 6:
            return serviceInput.intrinsicContentSize.height
        default:
            return dividerInput[2].intrinsicContentSize.height
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch row {
        case 0:
            return headerInput
        case 1:
            return directionInput
        case 2:
            return timeInput
        case 3:
            return dividerInput[0]
        case 4:
            return dayInput
        case 5:
            return dividerInput[1]
        case 6:
            return serviceInput
        default:
            return dividerInput[2]
        }
    }
}
