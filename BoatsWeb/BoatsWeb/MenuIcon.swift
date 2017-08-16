//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

class MenuIcon {
    
}

extension MenuIcon: DataEncoding {
    public func data() throws -> Data {
        guard let url: URL = Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "svg") else {
            throw NSError(domain: NSURLErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        return try Data(contentsOf: url)
    }
}
