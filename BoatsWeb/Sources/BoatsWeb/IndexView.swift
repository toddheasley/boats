import Foundation
import BoatsKit

struct IndexView: HTMLView {
    let index: Index
    
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
            return "<a href=\"\(RouteView(route: route, index: self.index).path)\"><b>\(route.name)</b>\(route.services.contains(.car) ? " \((try? SVG.car.html()) ?? SVG.car.description)" : "")</a>"
        case "INDEX_NAME":
            return "<a href=\"\(self.index.url.absoluteString)\">\(self.index.name)</a>"
        case "INDEX_DESCRIPTION":
            return "\(index)"
        case "TITLE", "NAME":
            return Site.name
        case "APP_ID":
            return Site.appIdentifier
        case "BOOKMARK_PATH":
            return BookmarkIcon().path
        case "STYLESHEET_PATH":
            return Stylesheet().path
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
    
    // MARK: Resource
    func data() throws -> Data {
        var html: HTML = try HTML(data: HTML_Data)
        html.dataSource = self
        return try html.data()
    }
}

private let HTML_Data: Data = """
<!DOCTYPE html>
<html>
    <head>
        <title><!-- TITLE --></title>
        <meta name="viewport" content="initial-scale=1.0">
        <meta name="apple-mobile-web-app-title" content="<!-- NAME -->">
<!-- APP_ID? -->
        <meta name="apple-itunes-app" content="app-id=<!-- APP_ID -->">
<!-- ?APP_ID -->
        <link rel="apple-touch-icon" href="<!-- BOOKMARK_PATH -->">
        <link rel="stylesheet" href="<!-- STYLESHEET_PATH -->">
    </head>
    <body>
        <nav></nav>
        <header>
            <h1><!-- INDEX_NAME --></h1>
        </header>
        <main>
            <h2></h2>
            <h1><!-- INDEX_DESCRIPTION --></h1>
            <section>
                <h3>Routes</h3>
                <table>
<!-- ROUTE[ -->
                    <tr>
                        <td><!-- ROUTE --></td>
                    </tr>
<!-- ]ROUTE -->
                </table>
            </section>
        </main>
    </body>
</html>
""".data(using: .utf8)!
