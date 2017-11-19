//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit
import BoatsWeb

class IndexViewController: NSViewController, NSOpenSavePanelDelegate {
    private let index: IndexInputGroup = IndexInputGroup()
    
    @IBOutlet var scrollView: NSScrollView?
    
    @IBAction func show(_ sender: AnyObject?) {
        guard let url: URL = IndexManager.url else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func preview(_ sender: AnyObject?) {
        guard IndexManager.web, let url: URL = IndexManager.url else {
            return
        }
        NSWorkspace.shared.openFile(url.appending(uri: Site.uri).path)
    }
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.tag {
        case 3:
            return IndexManager.index != nil
        case 4:
            return IndexManager.web
        default:
            return true
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        index.index = IndexManager.index
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView?.documentView?.autoresizingMask = [.height]
        scrollView?.documentView?.frame.size.height = view.bounds.size.height
        
        index.autoresizingMask = [.height]
        index.frame.size.height = view.bounds.size.height
        scrollView?.documentView?.addSubview(index)
    }
}
