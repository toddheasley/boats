import Foundation
import Boats

struct Stylesheet: Resource {
    
    // MARK: Resource
    public var path: String {
        return "stylesheet.css"
    }
    
    public func data() throws -> Data {
        return Stylesheet_Data
    }
}

private let Stylesheet_Data: Data = """
* {
    
}
""".data(using: .utf8)!
