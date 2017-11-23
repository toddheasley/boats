//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class RouteInputGroup: InputGroup {
    private let dividerInput: [DividerInput] = [DividerInput(), DividerInput(), DividerInput(), DividerInput(style: .none)]
    private let nameInput: StringInput = StringInput()
    private let uriInput: URIInput = URIInput()
    private let locationInput: (destination: LocationInput, origin: LocationInput) = (LocationInput(direction: .destination), LocationInput(direction: .origin))
    private let serviceInput: ServiceInput = ServiceInput()
    private var schedules: (header: Input, input: [ScheduleInput]) = (Input(), [ScheduleInput()])
    
    var route: Route? {
        set {
            nameInput.string = newValue?.name
            uriInput.uri = newValue?.uri
            locationInput.destination.location = newValue?.destination
            locationInput.origin.location = newValue?.origin
            serviceInput.services = newValue?.services ?? []
            schedules.input = []
            for schedule in newValue?.schedules ?? [] {
                schedules.input.append(ScheduleInput(schedule: schedule))
            }
            schedules.input.append(ScheduleInput())
            tableView.reloadData()
            isHidden = newValue == nil
        }
        get {
            var route: Route = Route()
            route.name = nameInput.string ?? ""
            route.uri = uriInput.uri ?? ""
            route.destination = locationInput.destination.location ?? Location()
            route.origin = locationInput.origin.location ?? Location()
            
            return route
        }
    }
    
    override var localization: Localization? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func setUp() {
        super.setUp()
        
        headerInput.label = "Route"
        nameInput.label = "Name"
        schedules.header.label = "Schedules"
        route = nil
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 11 + schedules.input.count
    }
    
    // MARK: NSTableViewDelegate
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        switch row {
        case 0:
            return headerInput.intrinsicContentSize.height
        case 1:
            return nameInput.intrinsicContentSize.height
        case 2:
            return uriInput.intrinsicContentSize.height
        case 3, 6, 8:
            return dividerInput[0].intrinsicContentSize.height
        case 4, 5:
            return locationInput.destination.intrinsicContentSize.height
        case 7:
            return serviceInput.intrinsicContentSize.height
        case 9:
            return schedules.header.intrinsicContentSize.height
        case tableView.numberOfRows - 1:
            return dividerInput[3].intrinsicContentSize.height
        default:
            return schedules.input.first!.intrinsicContentSize.height
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch row {
        case 0:
            return headerInput
        case 1:
            return nameInput
        case 2:
            return uriInput
        case 3:
            return dividerInput[0]
        case 4:
            return locationInput.destination
        case 5:
            return locationInput.origin
        case 6:
            return dividerInput[1]
        case 7:
            return serviceInput
        case 8:
            return dividerInput[2]
        case 9:
            return schedules.header
        case tableView.numberOfRows - 1:
            return dividerInput[3]
        default:
            return schedules.input[row - 10]
        }
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        switch tableView.selectedRow {
        case 4:
            delegate?.input?(group: self, didSelect: locationInput.destination.location)
        case 5:
            delegate?.input?(group: self, didSelect: locationInput.origin.location)
        default:
            if tableView.selectedRow > 9 {
                delegate?.input?(group: self, didSelect: route?.schedule(index: tableView.selectedRow - 9) ?? Schedule())
            } else {
                delegate?.input?(group: self, didSelect: nil)
            }
        }
    }
}

