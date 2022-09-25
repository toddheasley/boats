import Foundation
import Boats

struct Favicon: Resource {
    
    // MARK: Resource
    public let path: String = "favicon.ico"
    
    public func data() throws -> Data {
        guard let url: URL = Bundle.module.url(forResource: "Favicon", withExtension: "png") else {
            throw URLError(.fileDoesNotExist)
        }
        return try Data(contentsOf: url)
    }
}
