//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

extension URLWriting where Self: URIResource, Self: DataEncoding {
    public func write(to url: URL, completion: @escaping (Error?) -> Void) {
        let url: URL = URL(base: url, uri: uri, type: uri.type)
        switch url.scheme ?? "" {
        case "file":
            do {
                try data().write(to: url, options: Data.WritingOptions.atomic)
                completion(nil)
            } catch let error {
                completion(error)
            }
        default:
            completion(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil))
        }
    }
}
