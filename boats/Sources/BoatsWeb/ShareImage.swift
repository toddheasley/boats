import Foundation
import Boats

struct ShareImage: Resource {
    
    // MARK: Resource
    public var path: String {
        return "image.png"
    }
    
    public func data() throws -> Data {
        guard let url: URL = Bundle.module.url(forResource: "ShareImage", withExtension: "png") else {
            throw URLError(.fileDoesNotExist)
        }
        return try Data(contentsOf: url)
    }
}
