//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class IndexInputGroup: InputGroup {
    private let dividerInput: [DividerInput] = [DividerInput(), DividerInput(), DividerInput(style: .none)]
    private let nameInput: StringInput = StringInput()
    private let descriptionInput: StringInput = StringInput()
    private let localizationInput: LocalizationInput = LocalizationInput()
    private var providers: (header: Input, input: [ProviderInput]) = (Input(), [ProviderInput()])
    
    var index: Index? {
        set {
            nameInput.string = newValue?.name
            descriptionInput.string = newValue?.description
            localizationInput.localization = newValue?.localization
            providers.input = []
            for provider in newValue?.providers ?? [] {
                providers.input.append(ProviderInput(provider: provider))
            }
            providers.input.append(ProviderInput())
            tableView.reloadData()
        }
        get {
            var index: Index = Index()
            index.name = nameInput.string ?? ""
            index.description = descriptionInput.string ?? ""
            index.localization = localizationInput.localization ?? Localization()
            for input in providers.input {
                if let provider = input.provider {
                    index.providers.append(provider)
                }
            }
            return index
        }
    }
    
    override var localization: Localization? {
        set {
            guard let newValue = newValue else {
                return
            }
            index?.localization = newValue
            tableView.reloadData()
        }
        get {
            return index?.localization
        }
    }
    
    var web: Bool {
        set {
            headerInput.webButton.state = newValue ? .on : .off
        }
        get {
            return headerInput.webButton.state == .on
        }
    }
    
    var webButton: NSButton {
        return headerInput.webButton
    }
    
    override func setUp() {
        super.setUp()
        
        headerInput.label = "Index"
        headerInput.webButton.isHidden = false
        
        nameInput.label = "Name"
        descriptionInput.label = "Description"
        providers.header.label = "Providers"
        index = nil
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 8 + providers.input.count
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
        case 3, 5:
            return dividerInput[0].intrinsicContentSize.height
        case 4:
            return localizationInput.intrinsicContentSize.height
        case 6:
            return providers.header.intrinsicContentSize.height
        case tableView.numberOfRows - 1:
            return dividerInput[2].intrinsicContentSize.height
        default:
            return providers.input.first!.intrinsicContentSize.height
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
            return localizationInput
        case 5:
            return dividerInput[1]
        case 6:
            return providers.header
        case tableView.numberOfRows - 1:
            return dividerInput[2]
        default:
            return providers.input[row - 7]
        }
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow > 6 {
            delegate?.input?(group: self, didSelect: index?.provider(index: tableView.selectedRow - 7) ?? Provider())
        } else {
            delegate?.input?(group: self, didSelect: nil)
        }
    }
}
