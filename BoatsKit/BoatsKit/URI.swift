//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct URI: ExpressibleByStringLiteral, CustomStringConvertible {
    private var value: String = ""
    
    public var description: String {
        return value
    }
    
    public init(stringLiteral value: String) {
        self.value = String(value.characters.filter { character in
            "\(character)".rangeOfCharacter(from: .urlPathAllowed) != nil
        }).components(separatedBy: ".")[0].replacingOccurrences(of: "/", with: "").lowercased()
    }
}

extension URI: Codable {
    public func encode(to encoder: Encoder) throws {
        var container: SingleValueEncodingContainer = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    public init(from decoder: Decoder) throws {
        let container: SingleValueDecodingContainer = try decoder.singleValueContainer()
        self.value = try container.decode(String.self)
    }
}

extension URI: Hashable {
    public var hashValue: Int {
        return value.hashValue
    }
    
    public static func ==(x: URI, y: URI) -> Bool {
        return x.hashValue == y.hashValue
    }
}
