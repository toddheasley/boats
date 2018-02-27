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
    func value(of name: String, at i: [Int], in html: HTML) -> String? {
        switch name {
        case "ROUTE":
            guard !i.isEmpty else {
                return nil
            }
            let item: (route: Route, provider: Provider) = index.sorted[i[0]]
            return "<a href=\"\(item.provider.uri)-\(item.route.uri).html\">\(item.route.services.contains(.car) ? "\(SVG.car.html) " : "")<b>\(item.route.name)</b> From \(item.route.origin.name) <span>Operated by \(item.provider.name)</span></a>"
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
    
    func count(of name: String, at i: [Int], in html: HTML) -> Int {
        switch name {
        case "ROUTE":
            return index.sorted.count
        default:
            return 0
        }
    }
}
