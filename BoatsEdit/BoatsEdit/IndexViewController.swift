//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit
import BoatsWeb

class IndexViewController: NSViewController, NSOpenSavePanelDelegate {
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
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView?.documentView?.autoresizingMask = [.height]
        scrollView?.documentView?.frame.size.height = view.bounds.size.height
        
        let group = InputGroup()
        group.autoresizingMask = [.height]
        group.frame.size.height = view.bounds.size.height
        scrollView?.documentView?.addSubview(group)
        
        let input = CoordinateInput()
        input.frame.origin.x = 0.0
        input.frame.origin.y = view.bounds.size.height - input.frame.size.height
        input.frame.size.width = 0.0
        scrollView?.documentView?.addSubview(input)
        
        input.coordinate = Coordinate(43.6789807607588, -70.2020960258751)
    }
}
