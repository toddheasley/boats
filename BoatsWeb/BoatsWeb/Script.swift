//
// © 2017 @toddheasley
//

import Foundation
import BoatsKit

class Script {
    
}

extension Script: DataEncoding {
    
    // MARK: DataEncoding
    public func data() throws -> Data {
        guard let url: URL = Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "js") else {
            throw NSError(domain: NSURLErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        return try Data(contentsOf: url)
    }
}

extension Script: DataResource, DataWriting, DataDeleting {
    
    // MARK: DataResource
    public var uri: URI {
        return URI(resource: "script", type: "js")
    }
}
