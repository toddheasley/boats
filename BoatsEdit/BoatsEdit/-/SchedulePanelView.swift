import Cocoa
import BoatsKit

class SchedulePanelView: PanelView {
    private let dividerInput: [DividerInput] = [DividerInput(), DividerInput(), DividerInput()]
    private let seasonInput: SeasonInput = SeasonInput()
    private var holidays: (header: Input, input: [HolidayInput]) = (Input(), [HolidayInput()])
    private var departures: (header: Input, input: [DepartureInput]) = (Input(), [DepartureInput()])
    
    var schedule: Schedule? {
        set {
            seasonInput.season = newValue?.season
            holidays.input = []
            for holiday in newValue?.holidays ?? [] {
                holidays.input.append(HolidayInput(holiday: holiday))
            }
            holidays.input.append(HolidayInput())
            departures.input = []
            for departure in newValue?.departures ?? [] {
                departures.input.append(DepartureInput(departure: departure))
            }
            departures.input.append(DepartureInput())
            tableView.reloadData()
            isHidden = newValue == nil
        }
        get {
            var schedule: Schedule = Schedule()
            schedule.season = seasonInput.season ?? .evergreen
            for input in holidays.input {
                if let holiday = input.holiday {
                    schedule.holidays.append(holiday)
                }
            }
            for input in departures.input {
                if let departure = input.departure {
                    schedule.departures.append(departure)
                }
            }
            return schedule
        }
    }
    
    // MARK: PanelView
    override var localization: Localization? {
        didSet {
            seasonInput.timeZone = localization?.timeZone
            for input in holidays.input {
                input.timeZone = localization?.timeZone
            }
            for input in departures.input {
                input.timeZone = localization?.timeZone
            }
            tableView.reloadData()
        }
    }
    
    override var deleteLabel: String? {
        guard let season: Season = schedule?.season else {
            return "schedule"
        }
        switch season {
        case .spring:
            return "spring schedule"
        case .summer:
            return "summer schedule"
        case .fall:
            return "fall schedule"
        case .winter:
            return "winter schedule"
        case .evergreen:
            return "evergreen schedule"
        }
    }
    
    override func dragRange(for row: Int) -> ClosedRange<Int>? {
        if holidays.input.count > 2, (4...(holidays.input.count + 2)).contains(row) {
            return 4...(holidays.input.count + 3)
        } else if departures.input.count > 2, ((holidays.input.count + 6)...(holidays.input.count + departures.input.count + 4)).contains(row) {
            return (holidays.input.count + 6)...(holidays.input.count + departures.input.count + 5)
        }
        return nil
    }
    
    override func moveInput(from dragRow: Int, to dropRow: Int) {
        if dragRow < holidays.input.count + 3 {
            holidays.input.move(from: dragRow - 4, to: dropRow - 4)
        } else {
            departures.input.move(from: dragRow - (holidays.input.count + 6), to: dropRow - (holidays.input.count + 6))
        }
    }
    
    override func setUp() {
        super.setUp()
        
        headerInput.label = "Schedule"
        headerInput.deleteButton.isHidden = false
        seasonInput.delegate = self
        holidays.header.label = "Holidays"
        departures.header.label = "Departures"
        
        schedule = nil
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 7 + holidays.input.count + departures.input.count
    }
    
    // MARK: NSTableViewDelegate
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        switch row {
        case 0:
            return headerInput.intrinsicContentSize.height
        case 1:
            return seasonInput.intrinsicContentSize.height
        case 2, (3 + holidays.input.count):
            return dividerInput[0].intrinsicContentSize.height
        case tableView.numberOfRows - 1:
            return dividerInput[2].intrinsicContentSize.height
        default:
            return holidays.header.intrinsicContentSize.height
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch row {
        case 0:
            return headerInput
        case 1:
            return seasonInput
        case 2:
            return dividerInput[0]
        case 3:
            return holidays.header
        case 4 + holidays.input.count:
            return dividerInput[1]
        case 5 + holidays.input.count:
            return departures.header
        case tableView.numberOfRows - 1:
            return dividerInput[2]
        default:
            if row < 4 + holidays.input.count {
                return holidays.input[row - 4]
            } else {
                return departures.input[row - (6 + holidays.input.count)]
            }
        }
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow > 3, tableView.selectedRow < 4 + holidays.input.count {
            delegate?.panel(self, didSelect: schedule?.holiday(at: tableView.selectedRow - 4) ?? Holiday())
            selectedRow = tableView.selectedRow
        } else if tableView.selectedRow > 5 + holidays.input.count {
            delegate?.panel(self, didSelect: schedule?.departure(at: tableView.selectedRow - (6 + holidays.input.count)) ?? Departure())
            selectedRow = tableView.selectedRow
        } else {
            delegate?.panel(self, didSelect: nil)
            selectedRow = -1
        }
    }
    
    // MARK: PanelViewDelegate
    override func panelDidEdit(_ view: PanelView) {
        if selectedRow == tableView.selectedRow {
            if let holiday = (view as? HolidayPanelView)?.holiday, !holiday.name.isEmpty,
                tableView.selectedRow > 3, tableView.selectedRow < 4 + holidays.input.count {
                holidays.input[tableView.selectedRow - 4].holiday = holiday
                if tableView.selectedRow == 3 + holidays.input.count {
                    holidays.input.append(HolidayInput())
                    tableView.insertRows(at: IndexSet(integer: tableView.selectedRow + 1))
                }
            } else if let departure = (view as? DeparturePanelView)?.departure,
                tableView.selectedRow > 5 + holidays.input.count, tableView.selectedRow < tableView.numberOfRows - 1 {
                departures.input[tableView.selectedRow - (6 + holidays.input.count)].departure = departure
                if tableView.selectedRow == tableView.numberOfRows - 2 {
                    departures.input.append(DepartureInput())
                    tableView.insertRows(at: IndexSet(integer: tableView.selectedRow + 1))
                }
            }
        }
        delegate?.panelDidEdit(self)
    }
    
    override func panelDidDelete(_ view: PanelView) {
        switch view {
        case is HolidayPanelView:
            if tableView.selectedRow > 3, tableView.selectedRow < 3 + holidays.input.count {
                holidays.input.remove(at: tableView.selectedRow - 4)
            }
        default:
            if tableView.selectedRow > 5 + holidays.input.count, tableView.selectedRow < tableView.numberOfRows - 2 {
                departures.input.remove(at: tableView.selectedRow - (6 + holidays.input.count))
            }
        }
        tableView.reloadData()
        delegate?.panel(self, didSelect: nil)
        delegate?.panelDidEdit(self)
    }
}
