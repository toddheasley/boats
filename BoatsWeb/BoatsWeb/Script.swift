//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

class Script {
    let uri: URI = "script"
}

extension Script: DataEncoding {
    public func data() throws -> Data {
        guard let url: URL = Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "js") else {
            throw NSError(domain: NSURLErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        return try Data(contentsOf: url)
    }
}
