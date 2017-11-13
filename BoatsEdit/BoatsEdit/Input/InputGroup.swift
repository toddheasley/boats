//
// © 2017 @toddheasley
//

import Cocoa

class InputGroup: NSView, NSTableViewDataSource, NSTableViewDelegate {
    let separator: NSView = NSView()
    let table: NSTableView = NSTableView()
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 308.0, height: 0.0)
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
        
        separator.frame.origin.x = bounds.size.width - separator.frame.size.width
    }
    
    func setUp() {
        separator.wantsLayer = true
        separator.layer?.backgroundColor = NSColor.gray.cgColor
        separator.autoresizingMask = [.height]
        separator.frame.size.width = 0.5
        separator.frame.size.height = bounds.size.height
        addSubview(separator)
        
        table.dataSource = self
        table.delegate = self
        table.autoresizingMask = [.width, .height]
        table.frame.size = bounds.size
        addSubview(table)
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setUp()
    }
    
    // MARK: NSTableViewDataSource, NSTableViewDelegate
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 30
    }
    
    
}
