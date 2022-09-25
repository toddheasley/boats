import Foundation

extension JSONEncoder {
    static let shared: JSONEncoder = JSONEncoder(.secondsSince1970)
    
    convenience init(_ dateEncodingStrategy: DateEncodingStrategy) {
        self.init()
        self.dateEncodingStrategy = dateEncodingStrategy
    }
}
