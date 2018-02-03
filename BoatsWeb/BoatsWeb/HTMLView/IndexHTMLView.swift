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
        case "PROVIDER":
            guard !index.isEmpty else {
                return nil
            }
            let provider: Provider = self.index.providers[index[0]]
            guard let url = provider.url else {
                return "\(provider.name)"
            }
            return "<a href=\"\(url)\">\(provider.name)</a>"
        case "ROUTE":
            guard index.count > 1 else {
                return nil
            }
            let provider: Provider = self.index.providers[index[0]]
            let route: Route = provider.routes[index[1]]
            return "<a href=\"\(provider.uri)-\(route.uri).html\">\(route.name) <span>From \(route.origin.name)</span></a>"
        case "INDEX_NAME":
            return "\(self.index.name)"
        case "INDEX_DESCRIPTION":
            return "\(self.index.description)"
        case "TITLE", "APP_TITLE":
            return "\(Site.app.name)"
        case "APP_ID":
            return "\(Site.app.identifier!)"
        case "MANIFEST_URI":
            return "\(Manifest().uri.resource)"
        case "BOOKMARK_URI":
            return "\(BookmarkIcon().uri.resource)"
        case "STYLESHEET_URI":
            return "\(Stylesheet().uri.resource)"
        case "SCRIPT_URI":
            return "\(Script().uri.resource)"
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
                return 0
            }
            return self.index.providers[index[0]].routes.count
        default:
            return 0
        }
    }
}
