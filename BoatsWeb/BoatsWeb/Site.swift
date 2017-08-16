//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

public struct Site {
    public static var name: String = "Boats"
    public static var appIdentifier: String?
    public private(set) var index: Index
    
    public init(index: Index) {
        self.index = index
    }
}

extension Site: URLWriting {
    public func write(to url: URL, completion: (Error?) -> Void) {
        IndexView(index: index).document.write(to: url, completion: completion)
        for provider in index.providers {
            for route in provider.routes {
                RouteView(index: index, provider: provider, route: route).document.write(to: url, completion: completion)
            }
        }
        Stylesheet().write(to: url, completion: completion)
        BookmarkIcon().write(to: url, completion: completion)
    }
}
