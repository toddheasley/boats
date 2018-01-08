import Cocoa
import BoatsKit
import BoatsWeb

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSOpenSavePanelDelegate {
    private var window: NSWindow?
    private var hasPanel: Bool = false
    
    @IBAction func make(_ sender: AnyObject?) {
        hasPanel = true
        let panel: NSOpenPanel = NSOpenPanel()
        panel.delegate = self
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.canChooseFiles = false
        panel.prompt = "Choose Directory"
        panel.begin { result in
            self.hasPanel = false
        }
    }
    
    @IBAction func open(_ sender: AnyObject?) {
        hasPanel = true
        let panel: NSOpenPanel = NSOpenPanel()
        panel.delegate = self
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.prompt = "Open"
        panel.begin { result in
            self.hasPanel = false
        }
    }
    
    @IBAction func close(_ sender: AnyObject?) {
        IndexManager.url = nil
        window?.setIsVisible(false)
    }
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.tag {
        case 1:
            return !(window?.isVisible ?? false) && !hasPanel
        case 2:
            return window?.isVisible ?? false
        default:
            return true
        }
    }
    
    // MARK: NSApplicationDelegate
    func applicationWillFinishLaunching(_ notification: Notification) {
        Site.app.identifier = "1152562893"
        
        window = NSApplication.shared.windows.first
        window?.setIsVisible(false)
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        try? IndexManager.open()
        window?.setIsVisible(IndexManager.index != nil)
        if !(window?.isVisible ?? false) {
            open(self)
        }
    }
    
    // MARK: NSOpenSavePanelDelegate
    func panel(_ sender: Any, shouldEnable url: URL) -> Bool {
        if (sender as AnyObject).canChooseDirectories ?? false {
            return url.hasDirectoryPath
        } else {
            return url.hasDirectoryPath || IndexManager.canOpen(from: url)
        }
    }
    
    func panel(_ sender: Any, validate url: URL) throws {
        if (sender as AnyObject).canChooseDirectories ?? false {
            try IndexManager.make(at: url)
        } else {
            try IndexManager.open(from: url)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.window?.setIsVisible(IndexManager.index != nil)
        }
    }
}
