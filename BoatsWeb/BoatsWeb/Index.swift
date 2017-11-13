//
// © 2017 @toddheasley
//

import Foundation
import BoatsKit

extension Index {
    public func write(to url: URL, web: Bool) throws {
        try write(to: url)
        if web {
            try Site(index: self).write(to: url)
        } else {
            try Site(index: self).delete(from: url)
        }
    }
}
