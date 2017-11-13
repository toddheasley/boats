//
// © 2017 @toddheasley
//

import Cocoa

class InputRow: NSTableRowView {
    override var interiorBackgroundStyle: NSView.BackgroundStyle {
        return .light
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        NSColor.gridColor.withAlphaComponent(isEmphasized ? 0.42 : 0.21).setFill()
        let path: NSBezierPath = NSBezierPath(rect: dirtyRect)
        path.fill()
    }
}

/*
class PageRowView: NSTableRowView {
    private var index: Int = -1
    
    
    override func drawSelection(in dirtyRect: NSRect) {
        NSColor.gridColor.withAlphaComponent(isEmphasized ? 0.42: 0.21).setFill()
        let path = NSBezierPath(rect: dirtyRect)
        path.fill()
    }
    
    override func drawBackground(in dirtyRect: NSRect) {
        super.drawBackground(in: dirtyRect)
        
        guard let tableView = superview as? NSTableView, !isSelected else {
            return
        }
        
        tableView.gridColor.withAlphaComponent(0.7).setFill()
        if index + 1 < tableView.numberOfRows {
            NSBezierPath(rect: NSMakeRect(15.0, dirtyRect.size.height - 0.5, dirtyRect.size.width - 15.0, 0.5)).fill()
        }
        if index > 0 {
            NSBezierPath(rect: NSMakeRect(15.0, 0.0, dirtyRect.size.width - 15.0, 0.5)).fill()
        }
    }
    
    convenience init(index: Int) {
        self.init()
        self.index = index
    }
}*/
