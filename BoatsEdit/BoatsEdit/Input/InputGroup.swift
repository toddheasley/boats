//
// © 2017 @toddheasley
//

import Cocoa

class InputGroup: NSView, NSTableViewDataSource, NSTableViewDelegate {
    let table: NSTableView = NSTableView()
    let scroll: NSScrollView = NSScrollView()
    
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
        
        scroll.frame.size.width = bounds.size.width + 1.5
        scroll.frame.size.height = bounds.size.height + 2.0
    }
    
    func setUp() {
        table.headerView = nil
        table.allowsMultipleSelection = false
        table.addTableColumn(NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "Input")))
        table.dataSource = self
        table.delegate = self
        
        scroll.documentView = table
        scroll.hasVerticalScroller = true
        scroll.borderType = .bezelBorder
        scroll.frame.origin.x = -1.0
        scroll.frame.origin.y = -1.0
        addSubview(scroll)
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
}

fileprivate class InputRowView: NSTableRowView {
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
