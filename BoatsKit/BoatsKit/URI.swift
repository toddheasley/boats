//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct URI: ExpressibleByStringLiteral, CustomStringConvertible {
    private var name: String = ""
    public private(set) var type: String?
    
    public var description: String {
        return name
    }
    
    public var resource: String {
        return "\(name)\(!(type?.isEmpty ?? true) ? ".\(type!)" : "")"
    }
    
    public init(stringLiteral name: String) {
        let components: [String] = String(name.filter { element in
            "\(element)".rangeOfCharacter(from: .urlPathAllowed) != nil
        }).components(separatedBy: ".")
        self.name = components[0].replacingOccurrences(of: "/", with: "").lowercased()
        self.type = components.count > 1 && !components.last!.isEmpty ? components.last!.lowercased() : nil
    }
    
    public init(resource name: String, type: String? = nil) {
        self.init(stringLiteral: name)
        self.type = type
    }
}

extension URI: Codable {
    public func encode(to encoder: Encoder) throws {
        var container: SingleValueEncodingContainer = encoder.singleValueContainer()
        try container.encode(name)
    }
    
    public init(from decoder: Decoder) throws {
        let container: SingleValueDecodingContainer = try decoder.singleValueContainer()
        self.name = try container.decode(String.self)
    }
}

extension URI: Hashable {
    public var hashValue: Int {
        return name.hashValue
    }
    
    public static func ==(x: URI, y: URI) -> Bool {
        return x.hashValue == y.hashValue
    }
}
