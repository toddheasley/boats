import Foundation

extension JSONDecoder {
    static let shared: JSONDecoder = JSONDecoder(.secondsSince1970)
    
    convenience init(_ dateDecodingStrategy: DateDecodingStrategy) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
