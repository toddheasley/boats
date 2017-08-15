//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

public class Stylesheet {
    
}

extension Stylesheet: URIResource {
    public var uri: URI {
        return URI(stringLiteral: "stylesheet", type: "css")
    }
}

extension Stylesheet: DataEncoding {
    public func data() throws -> Data {
        guard let url: URL = Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "css") else {
            throw NSError(domain: NSURLErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        return try Data(contentsOf: url)
    }
}

extension Stylesheet: URLWriting {
    
}
