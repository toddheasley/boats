//
// © 2017 @toddheasley
//

import Foundation
import BoatsKit

class HTMLView {
    var name: URI = ""
    var html: HTML = ""
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
