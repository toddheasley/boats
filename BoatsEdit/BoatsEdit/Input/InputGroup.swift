//
// © 2017 @toddheasley
//

import Cocoa

class InputGroup: NSView, NSTableViewDataSource, NSTableViewDelegate {
    let tableView: NSTableView = NSTableView()
    let scrollView: NSScrollView = NSScrollView()
    let headerInput: HeaderInput = HeaderInput()
    
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
        
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true
        scrollView.borderType = .bezelBorder
        scrollView.frame.origin.x = -1.0
        scrollView.frame.origin.y = -1.0
        addSubview(scrollView)
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setUp()
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
}

class InputRowView: NSTableRowView {
    override var interiorBackgroundStyle: NSView.BackgroundStyle {
        return .light
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        if isEmphasized {
            NSColor.alternateSelectedControlColor.withAlphaComponent(0.21).setFill()
        } else {
            NSColor.gridColor.withAlphaComponent(0.21).setFill()
        }
        let path = NSBezierPath(rect: dirtyRect)
        path.fill()
    }
}