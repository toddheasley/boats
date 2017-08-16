//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

struct RouteView {
    private(set) var index: Index
    private(set) var provider: Provider
    private(set) var route: Route
    
    init(index: Index, provider: Provider, route: Route) {
        self.index = index
        self.provider = provider
        self.route = route
    }
}

extension RouteView: HTMLView {
    var document: HTMLDocument {
        return HTMLDocument(uri: URI(stringLiteral: "\(provider.uri)-\(route.uri)"), html: [
            HTML.head(title: "\(route.name) - \(provider.name)"),
            HTML.body(html: [
                HTML.nav(href: "\(HTMLDocument(uri: index.uri).uri.path)"),
                HTML.header(h1: "\(index.name)", h2: "\(index.description)")
            ])
        ])
    }
}
