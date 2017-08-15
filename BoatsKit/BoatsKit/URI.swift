//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public protocol URIResource {
    var uri: URI {
        get
    }
}

public struct URI: ExpressibleByStringLiteral, CustomStringConvertible {
    private var value: String = ""
    public private(set) var type: String = ""
    
    public var description: String {
        return value
    }
    
    public init(stringLiteral value: String, type: String) {
        self.value = String(value.characters.filter { character in
            "\(character)".rangeOfCharacter(from: .urlPathAllowed) != nil
        }).components(separatedBy: ".")[0].replacingOccurrences(of: "/", with: "").lowercased()
        self.type = type
    }
    
    public init(stringLiteral value: String) {
        self.init(stringLiteral: value, type: "")
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

extension URI: Equatable {
    public static func ==(x: URI, y: URI) -> Bool {
        return x.value == y.value
    }
}
