//
// © 2018 @toddheasley
//

import Foundation
import BoatsKit

class BookmarkIcon {
    
}

extension BookmarkIcon: DataEncoding {
    
    // MARK: DataEncoding
    public func data() throws -> Data {
        guard let url: URL = Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "png") else {
            throw NSError(domain: NSURLErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        return try Data(contentsOf: url)
    }
}

extension BookmarkIcon: DataResource, DataWriting, DataDeleting {
    
    // MARK: DataResource
    public var uri: URI {
        return URI(resource: "favicon", type: "png")
    }
}
