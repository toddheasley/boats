//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

struct JSON {
    static var encoder: JSONEncoder {
        let encoder: JSONEncoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
    
    static var decoder: JSONDecoder {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
