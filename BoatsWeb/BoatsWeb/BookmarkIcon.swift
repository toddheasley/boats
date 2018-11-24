import Foundation
import BoatsKit

struct BookmarkIcon {
    
}

extension BookmarkIcon: Resource {
    
    // MARK: Resource
    public var path: String {
        return "favicon.png"
    }
    
    public func data() throws -> Data {
        return try Data(contentsOf: try URL.bundle(resource: "BookmarkIcon", type: "png"))
    }
}

