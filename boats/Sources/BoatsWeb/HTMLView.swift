import Foundation
import Boats

protocol HTMLView: Resource {
    var html: [String] { get }
    var uri: String { get }
}

extension HTMLView {
    
    // MARK: Resource
    var path: String { "\(uri).html" }
    
    func data() throws -> Data {
        let html: String = html.joined(separator: "\n")
        guard let data: Data = html.data(using: .utf8) else {
            throw EncodingError.invalidValue(self, EncodingError.Context(codingPath: [], debugDescription: html))
        }
        return data
    }
}
