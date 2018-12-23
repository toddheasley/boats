import Foundation
import BoatsKit

struct IndexView: HTMLView {
    private(set) var index: Index
    
    init(index: Index) {
        self.index = index
    }
    
    // MARK: HTMLView
    var uri: String {
        return index.uri
    }
}

extension IndexView: HTMLDataSource {
    
    // MARK: HTMLDataSource
    func template(of name: String, at index: [Int]) -> String? {
        switch name {
        case "ROUTE":
            guard !index.isEmpty else {
                return nil
            }
            let route: Route = self.index.routes[index[0]]
            return "<a href=\"\(RouteView(route: route, index: self.index).path)\">\(route.services.contains(.car) ? "\((try? SVG.car.html()) ?? SVG.car.description) " : "")<b>\(route.name)</b> <span>\(route.location.description)</span></a>"
        case "INDEX_NAME":
            return "\(self.index.name)"
        case "INDEX_DESCRIPTION":
            return "\(self.index.description)"
        case "INDEX_URL":
            return "<a href=\"\(self.index.url.absoluteString)\">\(self.index.url.host ?? self.index.url.absoluteString)</a>"
        case "TITLE", "NAME":
            return "\(Site.name)"
        case "APP_ID":
            return Site.appIdentifier
        case "MANIFEST_PATH":
            return "\(Manifest().path)"
        case "BOOKMARK_PATH":
            return "\(BookmarkIcon().path)"
        case "STYLESHEET_PATH":
            return "\(Stylesheet().path)"
        case "SCRIPT_PATH":
            return "\(Script().path)"
        default:
            return nil
        }
    }
    
    func count(of name: String, at index: [Int]) -> Int {
        switch name {
        case "ROUTE":
            return self.index.routes.count
        default:
            return 0
        }
    }
}
