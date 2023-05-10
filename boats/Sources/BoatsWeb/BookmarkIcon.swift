import Foundation
import Boats

struct BookmarkIcon: Resource {
    
    // MARK: Resource
    public let path: String = "apple-touch-icon.png"
    
    public func data() throws -> Data {
        return try Bundle.module.data(forResource: "BookmarkIcon", withExtension: "png")
    }
}
