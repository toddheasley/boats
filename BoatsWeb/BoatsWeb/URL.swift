//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

extension URLWriting where Self: URIResource, Self: DataEncoding {
    public func write(to url: URL) throws {
        try data().write(to: URL(base: url, uri: uri, type: uri.type))
    }
}
