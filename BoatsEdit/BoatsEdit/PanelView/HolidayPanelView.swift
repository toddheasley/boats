import Cocoa
import BoatsKit

class HolidayPanelView: PanelView {
    private let dividerInput: [DividerInput] = [DividerInput(style: .none)]
    private let nameInput: StringInput = StringInput()
    private let dateInput: DateInput = DateInput()
    
    var holiday: Holiday? {
        set {
            nameInput.string = newValue?.name
            dateInput.date = newValue?.date
            tableView.reloadData()
            isHidden = newValue == nil
        }
        get {
            var holiday: Holiday = Holiday()
            holiday.name = nameInput.string ?? ""
            holiday.date = dateInput.date ?? Date()
            return holiday
        }
    }
    
    // MARK: PanelView
    override var localization: Localization? {
        didSet {
            dateInput.timeZone = localization?.timeZone
            tableView.reloadData()
        }
    }
    
    override var deleteLabel: String? {
        guard let name: String = holiday?.name, !name.isEmpty else {
            return "holiday"
        }
        return "\(name) holiday"
    }
    
    override func setUp() {
        super.setUp()
        
        headerInput.label = "Holiday"
        headerInput.deleteButton.isHidden = false
        nameInput.label = "Name"
        nameInput.placeholder = "Groundhog Day"
        nameInput.delegate = self
        dateInput.delegate = self
        
        holiday = nil
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 4
    }
    
    // MARK: NSTableViewDelegate
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        switch row {
        case 0:
            return headerInput.intrinsicContentSize.height
        case 1:
            return nameInput.intrinsicContentSize.height
        case 2:
            return dateInput.intrinsicContentSize.height
        default:
            return dividerInput[0].intrinsicContentSize.height
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch row {
        case 0:
            return headerInput
        case 1:
            return nameInput
        case 2:
            return dateInput
        default:
            return dividerInput[0]
        }
    }
}
