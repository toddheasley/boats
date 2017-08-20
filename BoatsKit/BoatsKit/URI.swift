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
    
    public var path: String {
        return "\(value)\(!type.isEmpty ? ".\(type)" : "")"
    }
    
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
    
    public init(path: String) {
        let components: [String] = path.components(separatedBy: ".")
        self.init(stringLiteral: components[0], type: components.count > 1 ? components.last! : "")
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
        return path.hashValue
    }
    
    public static func ==(x: URI, y: URI) -> Bool {
        return x.hashValue == y.hashValue
    }
}
