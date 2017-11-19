//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class IndexInputGroup: InputGroup {
    var index: Index? {
        didSet {
            table.reloadData()
        }
    }
    
    override func setUp() {
        super.setUp()
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return index != nil ? 30 : 0
    }
    
    // MARK: NSTableViewDelegate    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return Input().intrinsicContentSize.height
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return Input()
    }
}
