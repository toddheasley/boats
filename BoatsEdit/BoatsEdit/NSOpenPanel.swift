import Cocoa
import BoatsKit

extension NSOpenPanel {
    static var `default`: NSOpenPanel {
        let panel: NSOpenPanel = NSOpenPanel()
        panel.accessoryView = AccessoryView(delegate: panel)
        panel.accessoryView?.autoresizingMask = [.width]
        panel.accessoryView?.frame.size.width = panel.frame.size.width
        panel.isAccessoryViewDisclosed = true
        panel.canCreateDirectories = true
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.delegate = panel
        return panel
    }
    
    @discardableResult func index() throws -> Index {
        guard let url: URL = directoryURL else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil)
        }
        let data: Data = try Data(contentsOf: url.appendingPathComponent("index.json"))
        return try JSONDecoder().decode(Index.self, from: data)
    }
}

extension NSOpenPanel: NSOpenSavePanelDelegate {
    
    // MARK: NSOpenSavePanelDelegate
    public func panel(_ sender: Any, shouldEnable url: URL) -> Bool {
        return url.hasDirectoryPath
    }
    
    public func panel(_ sender: Any, validate url: URL) throws {
        try index()
    }
}

extension NSOpenPanel: AccessoryViewDelegate {
    
    // MARK: AccessoryViewDelegate
    func directory(for action: AccessoryView.Action) -> URL? {
        return self.directoryURL
    }
}
