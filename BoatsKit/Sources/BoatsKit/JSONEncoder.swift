import Foundation

extension JSONEncoder {
    static var shared: JSONEncoder {
        return JSONEncoder(dateEncodingStrategy: .secondsSince1970)
    }
    
    convenience init(dateEncodingStrategy: JSONEncoder.DateEncodingStrategy) {
        self.init()
        self.dateEncodingStrategy = dateEncodingStrategy
    }
}
