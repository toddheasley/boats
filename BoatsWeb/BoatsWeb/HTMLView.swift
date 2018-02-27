import Foundation
import BoatsKit

class HTMLView {
    private(set) var html: HTML = ""
    private(set) var name: URI = ""
    
    init?() {
        guard let url: URL = Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "html"),
            let data: Data = try? Data(contentsOf: url),
            let string: String = String(data: data, encoding: .utf8) else {
            return nil
        }
        self.html = HTML(stringLiteral: string)
    }
}

extension HTMLView: DataEncoding {
    
    // MARK: DataEncoding
    func data() throws -> Data {
        guard let data: Data = "\(html)".data(using: .utf8) else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFormattingError, userInfo: nil)
        }
        return data
    }
}

extension HTMLView: DataResource, DataWriting, DataDeleting {
    
    // MARK: DataResource
    var uri: URI {
        return URI(resource: "\(name)", type: "html")
    }
}
