//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

public struct Site {
    public private(set) var index: Index
    
    public init(index: Index) {
        self.index = index
    }
}

extension Site: DataWriting, DataDeleting {
    public func write(to url: URL) throws {
        try delete(from: url)
        var manifest: Manifest = Manifest()
        let view: IndexView = IndexView(index: index)
        try view.write(to: url)
        manifest.uris.insert(view.uri)
        for provider in index.providers {
            for route in provider.routes {
                let view: RouteView = RouteView(index: index, provider: provider, route: route)
                try view.write(to: url)
                manifest.uris.insert(view.uri)
            }
        }
        try BookmarkIcon().write(to: url)
        manifest.uris.insert(BookmarkIcon().uri)
        try Script().write(to: url)
        manifest.uris.insert(Script().uri)
        try Stylesheet().write(to: url)
        manifest.uris.insert(Stylesheet().uri)
        for svg: SVG in SVG.all {
            try svg.write(to: url)
            manifest.uris.insert(svg.uri)
        }
        try manifest.write(to: url)
    }
    
    public func delete(from url: URL) throws {
        guard let manifest: Manifest = try? Manifest(url: url) else {
            return
        }
        for uri in manifest.uris {
            try FileManager.default.removeItem(at: url.appending(uri: uri))
        }
    }
}
