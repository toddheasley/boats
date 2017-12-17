import Cocoa
import BoatsKit

class RoutePanelView: PanelView {
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
            route.services = serviceInput.services
            for input in schedules.input {
                if let schedule = input.schedule {
                    route.schedules.append(schedule)
                }
            }
            return route
        }
    }
    
    // MARK: PanelView
    override var localization: Localization? {
        didSet {
            for input in schedules.input {
                input.timeZone = localization?.timeZone
            }
            tableView.reloadData()
        }
    }
    
    override var deleteLabel: String? {
        guard let name: String = route?.name, !name.isEmpty else {
            return "route"
        }
        return "\(name) route"
    }
    
    override func dragRange(for row: Int) -> ClosedRange<Int>? {
        guard schedules.input.count > 2, (10...(schedules.input.count + 8)).contains(row) else {
            return nil
        }
        return 10...(schedules.input.count + 9)
    }
    
    override func moveInput(from dragRow: Int, to dropRow: Int) {
        schedules.input.move(from: dragRow - 10, to: dropRow - 10)
    }
    
    override func setUp() {
        super.setUp()
        
        headerInput.label = "Route"
        headerInput.deleteButton.isHidden = false
        nameInput.label = "Name"
        nameInput.delegate = self
        uriInput.delegate = self
        serviceInput.delegate = self
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
            delegate?.panel(self, didSelect: locationInput.destination.location)
            selectedRow = tableView.selectedRow
        case 5:
            delegate?.panel(self, didSelect: locationInput.origin.location)
            selectedRow = tableView.selectedRow
        default:
            if tableView.selectedRow > 9 {
                delegate?.panel(self, didSelect: route?.schedule(at: tableView.selectedRow - 10) ?? Schedule())
                selectedRow = tableView.selectedRow
            } else {
                delegate?.panel(self, didSelect: nil)
                selectedRow = -1
            }
        }
    }
    
    // MARK: PanelViewDelegate
    override func panelDidEdit(_ view: PanelView) {
        if selectedRow == tableView.selectedRow {
            if let location = (view as? LocationPanelView)?.location {
                switch tableView.selectedRow {
                case 4:
                    locationInput.destination.location = location
                case 5:
                    locationInput.origin.location = location
                default:
                    break
                }
            } else if let schedule = (view as? SchedulePanelView)?.schedule,
                tableView.selectedRow > 9, tableView.selectedRow < tableView.numberOfRows - 1 {
                schedules.input[tableView.selectedRow - 10].schedule = schedule
                if tableView.selectedRow == tableView.numberOfRows - 2 {
                    schedules.input.append(ScheduleInput())
                    tableView.insertRows(at: IndexSet(integer: tableView.selectedRow + 1))
                }
            }
        }
        delegate?.panelDidEdit(self)
    }
    
    override func panelDidDelete(_ view: PanelView) {
        if tableView.selectedRow > 9, tableView.selectedRow < tableView.numberOfRows - 2 {
            schedules.input.remove(at: tableView.selectedRow - 10)
        }
        tableView.reloadData()
        delegate?.panel(self, didSelect: nil)
        delegate?.panelDidEdit(self)
    }
}
