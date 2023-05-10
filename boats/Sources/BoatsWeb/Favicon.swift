import Foundation
import Boats

struct Favicon: Resource {
    
    // MARK: Resource
    public let path: String = "favicon.ico"
    
    public func data() throws -> Data {
        return try Bundle.module.data(forResource: "Favicon", withExtension: "png")
    }
}
