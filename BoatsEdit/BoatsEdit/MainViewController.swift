//
//  BoatsEdit
//  © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class MainViewController: NSViewController, NSOpenSavePanelDelegate {
    @IBAction func make(_ sender: AnyObject?) {
        
        
    }
    
    @IBAction func open(_ sender: AnyObject?) {
        
        let openPanel: NSOpenPanel = NSOpenPanel()
        openPanel.delegate = self
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        openPanel.canChooseFiles = true
        openPanel.begin{ result in
            guard result == .OK else {
                return
            }
            print(openPanel.url?.absoluteString ?? "")
        }
    }
    
    @IBAction func close(_ sender: AnyObject?) {
        
    }
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.tag {
        case 3:
            return IndexManager.index != nil
        default:
            return true
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        //view.window?.title = "Test"
        //view.window?.toolbar?.isVisible = false
        //view.window?.toolbar?.showsBaselineSeparator = false
        //view.window?.titlebarAppearsTransparent = true
        //view.window?.titleVisibility = .hidden
        
        //view.window?.backgroundColor = .white
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        //view.window?.setIsVisible(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: NSOpenSavePanelDelegate
    func panel(_ sender: Any, shouldEnable url: URL) -> Bool {
        return false //IndexManager.canOpen(from: url) || url.hasDirectoryPath
    }
    
    func panel(_ sender: Any, validate url: URL) throws {
        print("panel(validate: \(url))")
        throw NSError(domain: "Test", code: 0, userInfo: nil)
    }
    
    func panel(_ sender: Any, didChangeToDirectoryURL url: URL?) {
        print("panel(didChangeToDirectoryURL: \(url?.absoluteString ?? ""))")
    }
    
    func panelSelectionDidChange(_ sender: Any?) {
        print("panelSelectionDidChange(\((sender as? NSOpenPanel)?.url?.absoluteString ?? "")")
    }
}
