import Cocoa
import BoatsKit

protocol PanelViewDelegate {
    func panelView(_ view: PanelView, didSelect input: Any?)
    func panelViewDidEdit(_ view: PanelView)
    func panelViewDidDelete(_ view: PanelView)
}

class PanelView: NSView, NSTableViewDataSource, NSTableViewDelegate, PanelViewDelegate, InputViewDelegate {
    private let tableView: NSTableView = PanelTableView()
    private let scrollView: NSScrollView = PanelScrollView()
    let panelInputView: PanelInputView = PanelInputView()
    
    var selectedInput: Int? {
        return tableView.selectedRow > 0 ? tableView.selectedRow - 1 : nil
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
    
    func inputSelected(at i: Int?) {
        delegate?.panelView(self, didSelect: i != nil ? inputViews[i!].input : nil)
    }
    
    func dragRange(for i: Int) -> ClosedRange<Int>? {
        return nil
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
    
    override func updateLayer() {
        super.updateLayer()
        
        layer?.backgroundColor = NSColor.quaternaryLabelColor.cgColor
    }
    
    override func setUp() {
        super.setUp()
        
        panelInputView.delegate = self
        
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
        
        guard let row: Int = rowIndexes.first, let _: ClosedRange<Int> = dragRange(for: row - 1) else {
            return false
        }
        tableView.deselectAll(nil)
        pasteboard.declareTypes([.input], owner: self)
        pasteboard.setData(try? NSKeyedArchiver.archivedData(withRootObject: row as NSNumber, requiringSecureCoding: false), forType: .input)
        return true
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        guard info.draggingSource as? NSTableView == tableView, dropOperation == .above,
            let data: Data = info.draggingPasteboard.data(forType: .input),
            let dragRow: Int = (try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSNumber.self, from: data)) as? Int,
            let dragRange: ClosedRange<Int> = dragRange(for: dragRow - 1), dragRange.contains(row - 1), row != dragRow, row != dragRow + 1 else {
            return []
        }
        return .move
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        guard let data: Data = info.draggingPasteboard.data(forType: .input),
            let dragRow: Int = (try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSNumber.self, from: data)) as? Int,
            let dragRange: ClosedRange<Int> = dragRange(for: dragRow - 1), dragRange.contains(row - 1) else {
            return false
        }
        inputViews.move(from: dragRow - 1, to: row - 1)
        
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
            print(inputViews[row - 1].style)
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
        inputSelected(at: selectedInput)
    }
    
    // MARK: PanelViewDelegate
    func panelView(_ view: PanelView, didSelect input: Any?) {
        delegate?.panelView(view, didSelect: input)
    }
    
    func panelViewDidEdit(_ view: PanelView) {
        delegate?.panelViewDidEdit(self)
    }
    
    func panelViewDidDelete(_ view: PanelView) {
        delegate?.panelViewDidDelete(self)
    }
    
    // MARK: InputViewDelegate
    func inputViewDidEdit(_ view: InputView) {
        panelViewDidEdit(self)
    }
    
    func inputViewDidDelete(_ view: InputView) {
        let alert: NSAlert = NSAlert()
        alert.alertStyle = .critical
        alert.messageText = "Delete?"
        if let label: String = label, !label.isEmpty {
            alert.messageText = "Delete \(label)?"
        }
        alert.informativeText = "You can’t undo this action."
        alert.addButton(withTitle: "Delete")
        alert.addButton(withTitle: "Cancel")
        guard alert.runModal() == .alertFirstButtonReturn else {
            return
        }
        panelViewDidDelete(self)
    }
}

private class PanelRowView: NSTableRowView {
    
    // MARK: NSTableRowView
    override var interiorBackgroundStyle: NSView.BackgroundStyle {
        return .light
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        var rect: CGRect = dirtyRect
        rect.size.width -= (padding.width - 4.0)
        rect.size.height -= 4.0
        rect.origin.x += (padding.left - 2.0)
        rect.origin.y += 2.0
        
        NSColor.secondaryLabelColor.setFill()
        NSBezierPath(roundedRect: rect, xRadius: 3.5, yRadius: 3.5).fill()
    }
}

private class PanelTableView: NSTableView {
    
    // MARK: NSTableView
    override func validateProposedFirstResponder(_ responder: NSResponder, for event: NSEvent?) -> Bool {
        return true
    }
}

private class PanelScrollView: NSScrollView {
    
    // MARK: NSScrollView
    override func scrollWheel(with event: NSEvent) {
        guard usesPredominantAxisScrolling else {
            return super.scrollWheel(with: event)
        }
        var next: Bool = !hasVerticalScroller
        if abs(event.deltaX) > abs(event.deltaY) {
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
