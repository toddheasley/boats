//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class LocationInputGroup: InputGroup {
    private let dividerInput: [DividerInput] = [DividerInput(), DividerInput(style: .none)]
    private let nameInput: StringInput = StringInput()
    private let descriptionInput: StringInput = StringInput()
    private let coordinateInput: CoordinateInput = CoordinateInput()
    
    var location: Location? {
        set {
            nameInput.string = newValue?.name
            descriptionInput.string = newValue?.description
            coordinateInput.coordinate = newValue?.coordinate
            tableView.reloadData()
            isHidden = newValue == nil
        }
        get {
            var location: Location = Location()
            location.name = nameInput.string ?? ""
            location.description = descriptionInput.string ?? ""
            location.coordinate = coordinateInput.coordinate!
            return location
        }
    }
    
    // MARK: InputGroup
    override var localization: Localization? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func setUp() {
        super.setUp()
        
        headerInput.label = "Location"
        nameInput.label = "Name"
        nameInput.delegate = self
        descriptionInput.label = "Description"
        descriptionInput.delegate = self
        coordinateInput.delegate = self
        
        location = nil
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 6
    }
    
    // MARK: NSTableViewDelegate
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        switch row {
        case 0:
            return headerInput.intrinsicContentSize.height
        case 1:
            return nameInput.intrinsicContentSize.height
        case 2:
            return descriptionInput.intrinsicContentSize.height
        case 3:
            return dividerInput[0].intrinsicContentSize.height
        case 4:
            return coordinateInput.intrinsicContentSize.height
        default:
            return dividerInput[1].intrinsicContentSize.height
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch row {
        case 0:
            return headerInput
        case 1:
            return nameInput
        case 2:
            return descriptionInput
        case 3:
            return dividerInput[0]
        case 4:
            return coordinateInput
        default:
            return dividerInput[1]
        }
    }
}
