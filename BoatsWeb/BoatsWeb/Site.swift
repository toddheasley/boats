//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

public struct Site {
    private var index: Index!
    
    public init(index: Index) {
        self.index = index
    }
}

extension Site: URLWriting {
    public func write(to url: URL, completion: (Error?) -> Void) {
        completion(nil)
        
        /*
        let url: URL = URL(base: url, uri: Index().uri, type: "json")
        switch url.scheme ?? "" {
        case "file":
            do {
                try JSON.encoder.encode(self).write(to: url, options: Data.WritingOptions.atomic)
                completion(nil)
            } catch let error {
                completion(error)
            }
        default:
            completion(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil))
        }
        */
        
    }
}
