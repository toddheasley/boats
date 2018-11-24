import Foundation
import BoatsKit

struct Script {
    
}

extension Script: Resource {
    
    // MARK: Resource
    public var path: String {
        return "script.js"
    }
    
    public func data() throws -> Data {
        return try Data(contentsOf: try URL.bundle(resource: "Script", type: "js"))
    }
}
