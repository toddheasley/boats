//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

extension Index {
    public func write(to url: URL, web: Bool, completion: @escaping (Error?) -> Void) {
        write(to: url) { error in
            guard web, error == nil else {
                completion(error)
                return
            }
            Site(index: self).write(to: url) { error in
                completion(error)
            }
        }
    }
}
