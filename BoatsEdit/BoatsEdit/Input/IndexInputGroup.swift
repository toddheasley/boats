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
            index?.localization = newValue ?? Localization()
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
        nameInput.delegate = self
        descriptionInput.label = "Description"
        descriptionInput.delegate = self
        providers.header.label = "Providers"
        
        index = nil
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 8 + providers.input.count
    }
    
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pasteboard: NSPasteboard) -> Bool {
        delegate?.input(self, didSelect: nil)
        
        guard rowIndexes.count == 1, rowIndexes.first! > 6, rowIndexes.first! < tableView.numberOfRows - 2 else {
            return false
        }
        (tableView.view(atColumn: 0, row: rowIndexes.first!, makeIfNecessary: false) as? Input)?.isDragging = true
        pasteboard.declareTypes([.input], owner: self)
        pasteboard.setData(NSKeyedArchiver.archivedData(withRootObject: rowIndexes), forType: .input)
        return true
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        for input in providers.input {
            input.isDragging = false
        }
        guard dropOperation == .above,
            let data = info.draggingPasteboard().data(forType: .input),
            let first = (NSKeyedUnarchiver.unarchiveObject(with: data) as? IndexSet)?.first,
            row > 6, row < tableView.numberOfRows - 1, row != first, row != first + 1 else {
            return NSDragOperation()
        }
        return .move
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        guard let data = info.draggingPasteboard().data(forType: .input),
            let first = (NSKeyedUnarchiver.unarchiveObject(with: data) as? IndexSet)?.first,
            row > 6, row < tableView.numberOfRows - 1,
            let provider = index?.providers[first - 7] else {
            return false
        }
        index?.providers.remove(at: first - 7)
        index?.providers.insert(provider, at: (first < row ? row - 1: row) - 7)
        tableView.reloadData()
        
        delegate?.inputDidEdit(self)
        return true
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
            delegate?.input(self, didSelect: index?.provider(index: tableView.selectedRow - 7) ?? Provider())
        } else {
            delegate?.input(self, didSelect: nil)
        }
    }
    
    // MARK: InputGroupDelegate
    override func inputDidEdit(_ group: InputGroup) {
        if let provider = (group as? ProviderInputGroup)?.provider,
            tableView.selectedRow > 6, tableView.selectedRow < tableView.numberOfRows - 1 {
            providers.input[tableView.selectedRow - 7].provider = provider
            if tableView.selectedRow == tableView.numberOfRows - 2 {
                providers.input.append(ProviderInput())
                tableView.insertRows(at: IndexSet(integer: tableView.selectedRow + 1))
            }
        }
        delegate?.inputDidEdit(self)
    }
    
    override func inputDidDelete(_ group: InputGroup) {
        if tableView.selectedRow > 6, tableView.selectedRow < tableView.numberOfRows - 2 {
            providers.input.remove(at: tableView.selectedRow - 7)
        }
        tableView.reloadData()
        delegate?.input(self, didSelect: nil)
        delegate?.inputDidDelete(self)
    }
}
