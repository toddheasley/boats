import Cocoa
import BoatsKit
import BoatsWeb

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuItemValidation {
    @IBAction func open(_ sender: AnyObject?) {
        panel.begin { result in
            guard let index: Index = try? self.panel.index() else {
                return
            }
            (self.window?.contentViewController as? ViewController)?.index = index
            self.window?.setIsVisible(true)
        }
    }
    
    @IBAction func close(_ sender: AnyObject?) {
        window?.setIsVisible(false)
    }
    
    private var panel: NSOpenPanel = .default
    private var window: NSWindow?
    private var url: URL?
    
    // MARK: NSApplicationDelegate
    func applicationWillFinishLaunching(_ notification: Notification) {
        window = NSApplication.shared.windows.last
        window?.setIsVisible(false)
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        open(self)
    }
    
    // MARK: NSMenuItemValidation
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.tag {
        case 1:
            return !(window?.isVisible ?? true) && !panel.isVisible
        case 2:
            return window?.isVisible ?? false
        case 3:
            return false
        default:
            return false
        }
    }
}
