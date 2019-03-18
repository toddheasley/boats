import Cocoa
import BoatsKit
import BoatsWeb

extension NSOpenPanel {
    static var `default`: NSOpenPanel {
        let panel: NSOpenPanel = NSOpenPanel()
        panel.accessoryView = AccessoryView(delegate: panel)
        panel.accessoryView?.autoresizingMask = [.width]
        panel.accessoryView?.frame.size.width = panel.frame.size.width
        panel.canCreateDirectories = true
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.delegate = panel
        return panel
    }
    
    var webURL: URL? {
        do {
            try Site(index: try index()).build(to: try temporaryURL())
            return try temporaryURL(path: "index.html")
        } catch {
            return nil
        }
    }
    
    @discardableResult func index() throws -> Index {
        guard let url: URL = directoryURL else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil)
        }
        return try Index(from: url)
    }
    
    private func temporaryURL(path: String = "") throws -> URL {
        var url: URL = FileManager.default.temporaryDirectory.appendingPathComponent("boats")
        if !FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
        }
        url.appendPathComponent(path)
        guard FileManager.default.fileExists(atPath: url.path) else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorFileDoesNotExist, userInfo: nil)
        }
        return url
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
    func directoryFailed(error: Error) {
        NSAlert(error: error).beginSheetModal(for: self, completionHandler: nil)
    }
}
