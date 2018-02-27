import Cocoa
import BoatsKit

protocol PanelViewDelegate {
    func panelView(_ view: PanelView, didSelect input: Any?)
    func panelViewDidEdit(_ view: PanelView)
    func panelViewDidDelete(_ view: PanelView)
}

class PanelView: NSView, NSTableViewDataSource, NSTableViewDelegate, PanelViewDelegate, InputViewDelegate {
    private let panelInputView: PanelInputView = PanelInputView()
    private let tableView: NSTableView = PanelTableView()
    private let scrollView: NSScrollView = PanelScrollView()
    
    private(set) var selectedInput: Int? {
        didSet {
            print("selectedInput: \(selectedInput ?? -99)")
        }
    }
    
    var inputViews: [InputView] = [] {
        didSet {
            for inputView in inputViews {
                inputView.delegate = self
            }
            tableView.reloadData()
        }
    }
    
    var delegate: PanelViewDelegate?
    
    var label: String? {
        set {
            panelInputView.label = newValue
        }
        get {
            return panelInputView.label
        }
    }
    
    var localization: Localization? {
        didSet {
            tableView.reloadData()
        }
    }
    
    func dragRange(for i: Int) -> ClosedRange<Int>? {
        return nil
    }
    
    func delete(label: String? = nil) {
        let alert: NSAlert = NSAlert()
        alert.alertStyle = .critical
        alert.messageText = "Delete?"
        if let label = label, !label.isEmpty {
            alert.messageText = "Delete \(label)?"
        }
        alert.informativeText = "You can’t undo this action."
        alert.addButton(withTitle: "Delete")
        alert.addButton(withTitle: "Cancel")
        guard alert.runModal() == .alertFirstButtonReturn else {
            return
        }
        delegate?.panelViewDidDelete(self)
    }
    
    @objc func handleDelete(_ sender: AnyObject?) {
        delete()
    }
    
    // MARK: NSView
    override var intrinsicContentSize: NSSize {
        return CGSize(width: .inputWidth + 1.0, height: super.intrinsicContentSize.height)
    }
    
    override var frame: NSRect {
        set {
            super.frame = NSRect(x: newValue.origin.x, y: newValue.origin.y, width: intrinsicContentSize.width, height: newValue.size.height)
        }
        get {
            return super.frame
        }
    }
    
    override func setUp() {
        super.setUp()
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.separator.cgColor
        
        tableView.backgroundColor = .background
        tableView.headerView = nil
        tableView.allowsMultipleSelection = false
        tableView.addTableColumn(NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "Input")))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.setDraggingSourceOperationMask(.move, forLocal: true)
        tableView.registerForDraggedTypes([.input])
        
        scrollView.documentView = tableView
        scrollView.borderType = .noBorder
        scrollView.hasVerticalScroller = true
        scrollView.autoresizingMask = [.height]
        scrollView.frame.size.width = intrinsicContentSize.width - 0.5
        scrollView.frame.size.height = bounds.size.height
        addSubview(scrollView)
        
        //titleInputView
        //headerInput.deleteButton.target = self
        //headerInput.deleteButton.action = #selector(delete(_:))
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return inputViews.count + 1
    }
    
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pasteboard: NSPasteboard) -> Bool {
        panelView(self, didSelect: nil)
        
        guard let row: Int = rowIndexes.first, let _: ClosedRange = dragRange(for: row) else {
            return false
        }
        tableView.deselectAll(nil)
        pasteboard.declareTypes([.input], owner: self)
        pasteboard.setData(NSKeyedArchiver.archivedData(withRootObject: rowIndexes), forType: .input)
        return true
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        guard info.draggingSource() as? NSTableView == tableView, dropOperation == .above,
            let data: Data = info.draggingPasteboard().data(forType: .input),
            let dragRow: Int = (NSKeyedUnarchiver.unarchiveObject(with: data) as? IndexSet)?.first,
            let dragRange: ClosedRange<Int> = dragRange(for: dragRow), dragRange.contains(row), row != dragRow, row != dragRow + 1 else {
            return []
        }
        return .move
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        guard let data: Data = info.draggingPasteboard().data(forType: .input),
            let dragRow: Int = (NSKeyedUnarchiver.unarchiveObject(with: data) as? IndexSet)?.first,
            let dragRange: ClosedRange<Int> = dragRange(for: dragRow), dragRange.contains(row) else {
            return false
        }
        inputViews.move(from: dragRow, to: row)
        
        delegate?.panelViewDidEdit(self)
        return true
    }
    
    // MARK: NSTableViewDelegate
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        switch row {
        case 0:
            return panelInputView.intrinsicContentSize.height
        default:
            return inputViews[row - 1].intrinsicContentSize.height
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch row {
        case 0:
            return panelInputView
        default:
            return inputViews[row - 1]
        }
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return PanelRowView()
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return (tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as? InputView)?.allowsSelection ?? false
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        selectedInput = tableView.selectedRow > 0 ? tableView.selectedRow - 1 : nil
    }
    
    // MARK: PanelViewDelegate
    func panelView(_ view: PanelView, didSelect input: Any?) {
        delegate?.panelView(view, didSelect: input)
    }
    
    func panelViewDidEdit(_ view: PanelView) {
        delegate?.panelViewDidEdit(self)
    }
    
    func panelViewDidDelete(_ view: PanelView) {
        
    }
    
    // MARK: InputViewDelegate
    func inputViewDidEdit(_ view: InputView) {
        delegate?.panelViewDidEdit(self)
    }
}

fileprivate class PanelRowView: NSTableRowView {
    
    // MARK: NSTableRowView
    override var interiorBackgroundStyle: NSView.BackgroundStyle {
        return .light
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        NSColor.gridColor.withAlphaComponent(0.12).setFill()
        if isEmphasized {
            NSColor.tint.setFill()
        }
        let path = NSBezierPath(rect: dirtyRect)
        path.fill()
    }
}

fileprivate class PanelTableView: NSTableView {
    
    // MARK: NSTableView
    override func validateProposedFirstResponder(_ responder: NSResponder, for event: NSEvent?) -> Bool {
        return true
    }
}

fileprivate class PanelScrollView: NSScrollView {
    
    // MARK: NSScrollView
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

extension NSPasteboard.PasteboardType {
    fileprivate static var input: NSPasteboard.PasteboardType {
        return NSPasteboard.PasteboardType("Input")
    }
}
