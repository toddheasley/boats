//
//  BoatsEdit
//  © 2017 @toddheasley
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    override func validateMenuItem(_ item: NSMenuItem) -> Bool {
        print(item)
        return false
    }
    
    // MARK: NSApplicationDelegate
    func applicationDidFinishLaunching(_ notification: Notification) {
        
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true;
    }

    func applicationWillTerminate(_ notification: Notification) {
        
    }
}
