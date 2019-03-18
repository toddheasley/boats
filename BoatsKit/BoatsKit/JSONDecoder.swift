import Foundation

extension JSONDecoder {
    static var shared: JSONDecoder {
        return JSONDecoder(dateDecodingStrategy: .secondsSince1970)
    }
    
    convenience init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
