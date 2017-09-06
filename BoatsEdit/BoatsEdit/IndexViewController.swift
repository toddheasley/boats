//
//  BoatsEdit
//  © 2017 @toddheasley
//

import Cocoa

class IndexViewController: NSViewController, NSOpenSavePanelDelegate {
    @IBAction func show(_ sender: AnyObject?) {
        
    }
    
    @IBAction func preview(_ sender: AnyObject?) {
        
    }
    
    @IBAction func make(_ sender: AnyObject?) {
        let panel: NSOpenPanel = NSOpenPanel()
        panel.delegate = self
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.canChooseFiles = false
        panel.prompt = "Choose Directory"
        panel.begin { result in
            guard result == .OK else {
                return
            }
            
        }
    }
    
    @IBAction func open(_ sender: AnyObject?) {
        let panel: NSOpenPanel = NSOpenPanel()
        panel.delegate = self
        panel.canChooseDirectories = true
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.prompt = "Open"
        panel.begin { result in
            guard result == .OK else {
                return
            }
            
        }
    }
    
    @IBAction func close(_ sender: AnyObject?) {
        
    }
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.tag {
        case 1:
            return IndexManager.index != nil
        default:
            return true
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.setIsVisible(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try? IndexManager.open()
    }
    
    // MARK: NSOpenSavePanelDelegate
    func panel(_ sender: Any, shouldEnable url: URL) -> Bool {
        if (sender as AnyObject).canCreateDirectories ?? false {
            return url.hasDirectoryPath
        } else {
            return IndexManager.canOpen(from: url)
        }
    }
    
    func panel(_ sender: Any, validate url: URL) throws {
        if (sender as AnyObject).canCreateDirectories ?? false {
            try IndexManager.make(at: url)
        } else {
            try IndexManager.open(from: url)
        }
    }
    
    func panel(_ sender: Any, didChangeToDirectoryURL url: URL?) {
        
    }
    
    func panelSelectionDidChange(_ sender: Any?) {
        
    }
}
