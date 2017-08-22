//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

extension Index {
    public func write(to url: URL, web: Bool, completion: @escaping (Error?) -> Void) {
        write(to: url) { error in
            if let error = error {
                completion(error)
                return
            }
            if web {
                Site(index: self).write(to: url) { error in
                    completion(error)
                }
            } else {
                Site(index: self).delete(from: url) { error in
                    completion(error)
                }
            }
        }
    }
}
