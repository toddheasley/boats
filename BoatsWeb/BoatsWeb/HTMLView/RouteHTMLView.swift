import Foundation
import BoatsKit

class RouteHTMLView: HTMLView, HTMLDataSource {
    private(set) var index: Index!
    private(set) var provider: Provider!
    private(set) var route: Route!
    
    init?(index: Index, provider: Provider, route: Route) {
        super.init()
        self.index = index
        self.provider = provider
        self.route = route
        html.dataSource = self
    }
    
    // MARK: HTMLView
    override var name: URI {
        return URI(stringLiteral: "\(provider.uri)-\(route.uri)")
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
        case "TITLE":
            return "\(route.name) - \(provider.name)"
        case "INDEX.URI":
            return Site.uri.resource
        case "INDEX.NAME":
            return self.index.name
        case "INDEX.DESCRIPTION":
            return self.index.description
        case "SVG.MENU":
            return "\(SVG.menu.html)"
        default:
            return nil
        }
    }
    
    func count(of name: String, at index: [Int], in html: HTML) -> Int {
        return 0
    }
}
