//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

class Stylesheet {
    public let uri: URI = "stylesheet"
}

extension Stylesheet: DataEncoding {
    func data() throws -> Data {
        guard let url: URL = Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "css") else {
            throw NSError(domain: NSURLErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        return try Data(contentsOf: url)
    }
}
