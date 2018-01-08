import Foundation
import BoatsKit

class IndexHTMLView: HTMLView, HTMLDataSource {
    private(set) var index: Index!
    
    init?(index: Index) {
        super.init()
        self.index = index
        html.dataSource = self
    }
    
    // MARK: HTMLView
    override var name: URI {
        return URI(stringLiteral: "\(Site.uri)")
    }
    
    // MARK: HTMLDataSource
    func value(of name: String, at index: [Int], in html: HTML) -> String? {
        switch name {
        case "MANIFEST.URI":
            return Manifest().uri.resource
        case "APP.NAME":
            return Site.app.name
        case "APP.IDENTIFIER":
            return Site.app.identifier
        case "BOOKMARK.URI":
            return BookmarkIcon().uri.resource
        case "STYLESHEET.URI":
            return Stylesheet().uri.resource
        case "SCRIPT.URI":
            return Script().uri.resource
        case "INDEX.NAME":
            return self.index.name
        case "INDEX.DESCRIPTION":
            return self.index.description
        case "PROVIDER.NAME":
            guard !index.isEmpty else {
                return nil
            }
            return self.index.providers[index[0]].name
        case "PROVIDER.URL":
            guard !index.isEmpty else {
                return nil
            }
            return self.index.providers[index[0]].url?.absoluteString
        case "ROUTE.URI":
            guard index.count > 1 else {
                return nil
            }
            return ""
        case "ROUTE.NAME":
            guard index.count > 1 else {
                return nil
            }
            return self.index.providers[index[0]].routes[index[1]].name
        case "ROUTE.ORIGIN":
            guard index.count > 1 else {
                return nil
            }
            return self.index.providers[index[0]].routes[index[1]].origin.name
        default:
            return nil
        }
    }
    
    func count(of name: String, at index: [Int], in html: HTML) -> Int {
        switch name {
        case "PROVIDER":
            return self.index.providers.count
        case "ROUTE":
            guard !index.isEmpty else {
                fallthrough
            }
            return self.index.providers[index[0]].routes.count
        default:
            return 0
        }
    }
}
