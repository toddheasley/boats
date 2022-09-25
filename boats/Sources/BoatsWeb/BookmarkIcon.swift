import Foundation
import Boats

struct BookmarkIcon: Resource {
    
    // MARK: Resource
    public let path: String = "apple-touch-icon.png"
    
    public func data() throws -> Data {
        guard let url: URL = Bundle.module.url(forResource: "BookmarkIcon", withExtension: "png") else {
            throw URLError(.fileDoesNotExist)
        }
        return try Data(contentsOf: url)
    }
}
