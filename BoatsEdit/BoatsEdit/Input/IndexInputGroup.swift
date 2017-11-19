//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class IndexInputGroup: InputGroup {
    private let dividerInput: [DividerInput] = [DividerInput(), DividerInput()]
    private let nameInput: StringInput = StringInput()
    private let descriptionInput: StringInput = StringInput()
    private let localizationInput: LocalizationInput = LocalizationInput()
    private var provider: (header: Input, input: [ProviderInput]) = (Input(), [ProviderInput()])
    
    
    var index: Index? {
        didSet {
            if let index = index {
                nameInput.string = index.name
                descriptionInput.string = index.description
                localizationInput.localization = index.localization
                provider.input = []
                for provider in index.providers {
                    self.provider.input.append(ProviderInput(provider: provider))
                }
                provider.input.append(ProviderInput())
            }
            tableView.reloadData()
        }
    }
    
    override func setUp() {
        super.setUp()
        
        headerInput.label = "Index"
        nameInput.label = "Name"
        descriptionInput.label = "Description"
        provider.header.label = "Providers"
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return index != nil ? 7 + provider.input.count : 0
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
            return provider.header.intrinsicContentSize.height
        default:
            return provider.input.first!.intrinsicContentSize.height
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
            return provider.header
        default:
            return provider.input[row - 7]
        }
    }
}
