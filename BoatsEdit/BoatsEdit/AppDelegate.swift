import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuItemValidation {
    @IBAction func open(_ sender: AnyObject?) {
        panel.begin { response in
            guard response == .OK,
                let url: URL = self.panel.webURL else {
                return
            }
            NSWorkspace.shared.openFile(url.path)
        }
    }
    
    @IBAction func show(_ sender: AnyObject?) {
        guard let url: URL = panel.directoryURL else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    private var panel: NSOpenPanel = .default
    
    // MARK: NSApplicationDelegate
    func applicationDidFinishLaunching(_ notification: Notification) {
        open(self)
    }
    
    // MARK: NSMenuItemValidation
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.tag {
        case 1:
            return !panel.isVisible
        case 2:
            return panel.isVisible && panel.directoryURL != nil
        default:
            return false
        }
    }
}
