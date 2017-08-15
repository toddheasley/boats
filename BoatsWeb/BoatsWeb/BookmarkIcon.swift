//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

public class BookmarkIcon {
    
}

extension BookmarkIcon: URIResource {
    public var uri: URI {
        return URI(stringLiteral: "favicon", type: "png")
    }
}

extension BookmarkIcon: DataEncoding {
    public func data() throws -> Data {
        guard let url: URL = Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "png") else {
            throw NSError(domain: NSURLErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        return try Data(contentsOf: url)
    }
}

extension BookmarkIcon: URLWriting {
    
}
