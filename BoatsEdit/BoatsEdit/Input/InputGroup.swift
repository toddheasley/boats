//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

protocol InputGroupDelegate {
    func input(_ group: InputGroup, didSelect input: Any?)
    func inputDidEdit(_ group: InputGroup)
    func inputDidDelete(_ group: InputGroup)
}

class InputGroup: NSView, NSTableViewDataSource, NSTableViewDelegate, InputGroupDelegate, InputDelegate {
    let tableView: NSTableView = NSTableView()
    let scrollView: NSScrollView = InputScrollView()
    let headerInput: HeaderInput = HeaderInput()
    
    var delegate: InputGroupDelegate?
    var localization: Localization?
    
    func dragRange(for row: Int) -> ClosedRange<Int>? {
        return nil
    }
    
    func moveInput(from dragRow: Int, to dropRow: Int) {
        
    }
    
    @IBAction func delete(_ sender: AnyObject?) {
        let alert: NSAlert = NSAlert()
        alert.messageText = "Message text"
        alert.informativeText = "Informative text"
        alert.addButton(withTitle: "Delete")
        alert.addButton(withTitle: "Cancel")
        guard alert.runModal() == .alertFirstButtonReturn else {
            return
        }
        delegate?.inputDidDelete(self)
    }
    
    override var intrinsicContentSize: NSSize {
        return Input().intrinsicContentSize
    }
    
    override var frame: NSRect {
        set {
            super.frame.size.width = intrinsicContentSize.width
            super.frame.size.height = newValue.size.height
            super.frame.origin = newValue.origin
        }
        get {
            return super.frame
        }
    }
    
    override func layout() {
        super.layout()
        
        scrollView.frame.size.width = bounds.size.width + 1.5
        scrollView.frame.size.height = bounds.size.height + 2.0
    }
    
    func setUp() {
        tableView.headerView = nil
        tableView.allowsMultipleSelection = false
        tableView.addTableColumn(NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "Input")))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.setDraggingSourceOperationMask(.move, forLocal: true)
        tableView.registerForDraggedTypes([.input])
        
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true
        scrollView.borderType = .bezelBorder
        scrollView.frame.origin.x = -1.0
        scrollView.frame.origin.y = -1.0
        addSubview(scrollView)
        
        headerInput.deleteButton.target = self
        headerInput.deleteButton.action = #selector(delete(_:))
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setUp()
    }
    
    // MARK: NSTableViewDataSource
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pasteboard: NSPasteboard) -> Bool {
        input(self, didSelect: nil)
        
        guard let row = rowIndexes.first, let _ = dragRange(for: row) else {
            return false
        }
        tableView.deselectAll(nil)
        (tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as? Input)?.isDragging = true
        pasteboard.declareTypes([.input], owner: self)
        pasteboard.setData(NSKeyedArchiver.archivedData(withRootObject: rowIndexes), forType: .input)
        return true
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        for row in 0...(tableView.numberOfRows - 1) {
            (tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as? Input)?.isDragging = false
        }
        guard info.draggingSource() as? NSTableView == tableView, dropOperation == .above,
            let data = info.draggingPasteboard().data(forType: .input), 
            let dragRow = (NSKeyedUnarchiver.unarchiveObject(with: data) as? IndexSet)?.first,
            let dragRange = dragRange(for: dragRow), dragRange.contains(row), row != dragRow, row != dragRow + 1 else {
            return []
        }
        return .move
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        guard let data = info.draggingPasteboard().data(forType: .input),
            let dragRow = (NSKeyedUnarchiver.unarchiveObject(with: data) as? IndexSet)?.first,
            let dragRange = dragRange(for: dragRow), dragRange.contains(row) else {
            return false
        }
        moveInput(from: dragRow, to: row)
        tableView.reloadData()
        
        delegate?.inputDidEdit(self)
        return true
    }
    
    // MARK: NSTableViewDelegate
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return InputRowView()
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        guard let input = tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as? Input, input.allowsSelection else {
            return false
        }
        (tableView.view(atColumn: 0, row: max(tableView.selectedRow, 0), makeIfNecessary: false) as? Input)?.isSelected = false
        (tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as? Input)?.isSelected = true
        return true
    }
    
    // MARK: InputGroupDelegate
    func input(_ group: InputGroup, didSelect input: Any?) {
        delegate?.input(group, didSelect: input)
    }
    
    func inputDidEdit(_ group: InputGroup) {
        delegate?.inputDidEdit(self)
    }
    
    func inputDidDelete(_ group: InputGroup) {
        
    }
    
    // MARK: InputDelegate
    func inputDidEdit(_ input: Input) {
        delegate?.inputDidEdit(self)
    }
}

class InputRowView: NSTableRowView {
    override var interiorBackgroundStyle: NSView.BackgroundStyle {
        return .light
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        NSColor.gridColor.withAlphaComponent(0.12).setFill()
        if isEmphasized {
            NSColor.alternateSelectedControlColor.withAlphaComponent(0.12).setFill()
        }
        let path = NSBezierPath(rect: dirtyRect)
        path.fill()
    }
}

fileprivate class InputScrollView: NSScrollView {
    override func scrollWheel(with event: NSEvent) {
        guard usesPredominantAxisScrolling else {
            return super.scrollWheel(with: event)
        }
        var next: Bool = !hasVerticalScroller
        if fabs(event.deltaX) > fabs(event.deltaY) {
            next = !hasHorizontalScroller
        }
        if next {
            nextResponder?.scrollWheel(with: event)
        } else {
            super.scrollWheel(with: event)
        }
    }
}

fileprivate extension NSPasteboard.PasteboardType {
    static var input: NSPasteboard.PasteboardType {
        return NSPasteboard.PasteboardType("Input")
    }
}
