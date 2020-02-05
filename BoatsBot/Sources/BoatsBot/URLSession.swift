import Foundation
import BoatsKit

extension URLSession {
    public func index(cache timeInterval: TimeInterval = 0.0, completion: @escaping (Index?, Error?) -> Void) {
        if let index: Index = Index(cache: timeInterval), index.route?.schedule() != nil {
            completion(index, nil)
        } else {
            index(action: .fetch) { index, error in
                index?.cache()
                completion(index, error)
            }
        }
    }
}
