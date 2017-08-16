//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

protocol HTMLView {
    var document: HTMLDocument {
        get
    }
}

struct HTMLDocument: URIResource {
    private(set) var uri: URI = ""
    var html: HTML = ""
    
    init(uri: URI) {
        self.uri = URI(stringLiteral: "\(uri)", type: "html")
    }
}

extension HTMLDocument: DataEncoding {
    public func data() throws -> Data {
        guard let data: Data = "\(html)".data(using: .utf8) else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFormattingError, userInfo: nil)
        }
        return data
    }
}

extension HTMLDocument: URLWriting {
    
}
