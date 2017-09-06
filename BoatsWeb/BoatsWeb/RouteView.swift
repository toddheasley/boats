//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

class RouteView: HTMLView {
    required public init(index: Index, provider: Provider, route: Route) {
        super.init()
        self.name = URI(resource: "\(provider.uri)-\(route.uri)")
        self.html = HTML(stringLiteral: "<!-- \(route.name) - \(provider.name) -->")
    }
}

