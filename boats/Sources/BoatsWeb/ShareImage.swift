import Foundation
import Boats

struct ShareImage: Resource {
    
    // MARK: Resource
    public let path: String = "share-image.png"
    
    public func data() throws -> Data {
        return try Bundle.module.data(forResource: "ShareImage", withExtension: "png")
    }
}
