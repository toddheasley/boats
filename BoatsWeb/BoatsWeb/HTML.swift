//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

struct HTML: ExpressibleByStringLiteral, CustomStringConvertible {
    private var value: String = ""
    
    public var description: String {
        return value
    }
    
    public init(stringLiteral value: String) {
        self.value = value
    }
}

extension HTML: DataEncoding {
    public func data() throws -> Data {
        guard let data: Data = "\(self)".data(using: .utf8) else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFormattingError, userInfo: nil)
        }
        return data
    }
}
