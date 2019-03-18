import Foundation
import BoatsKit

struct Stylesheet {
    
}

extension Stylesheet: Resource {
    
    // MARK: Resource
    public var path: String {
        return "stylesheet.css"
    }
    
    public func data() throws -> Data {
        return try Data(contentsOf: try URL.bundle(resource: "Stylesheet", type: "css"))
    }
}
