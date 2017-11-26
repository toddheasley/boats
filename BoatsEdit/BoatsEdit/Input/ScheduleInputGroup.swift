//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class ScheduleInputGroup: InputGroup {
    private let dividerInput: [DividerInput] = [DividerInput(), DividerInput(), DividerInput(style: .none)]
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
    
    override var localization: Localization? {
        didSet {
            tableView.reloadData()
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
        if tableView.selectedRow > 5 + holidays.input.count {
            delegate?.input(self, didSelect: schedule?.departures(index: tableView.selectedRow - (6 + holidays.input.count)) ?? Departure())
        } else {
            delegate?.input(self, didSelect: nil)
        }
    }
}
