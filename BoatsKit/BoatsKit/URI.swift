import Foundation

public struct URI: CustomStringConvertible, ExpressibleByStringLiteral {
    private var name: String = ""
    public private(set) var type: String?
    
    public var resource: String {
        return "\(name)\(!(type?.isEmpty ?? true) ? ".\(type!)" : "")"
    }
    
    public init(resource name: String, type: String? = nil) {
        self.init(stringLiteral: name)
        self.type = type
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return name
    }
    
    // MARK: ExpressibleByStringLiteral
    public init(stringLiteral name: String) {
        let components: [String] = String(name.filter { element in
            "\(element)".rangeOfCharacter(from: .urlPathAllowed) != nil
        }).components(separatedBy: ".")
        self.name = components[0].replacingOccurrences(of: "/", with: "").lowercased()
        self.type = components.count > 1 && !components.last!.isEmpty ? components.last!.lowercased() : nil
    }
}

extension URI: Equatable {
    public static func ==(x: URI, y: URI) -> Bool {
        return x.name == y.name
    }
}

extension URI: Codable {
    
    // MARK: Codable
    public func encode(to encoder: Encoder) throws {
        var container: SingleValueEncodingContainer = encoder.singleValueContainer()
        try container.encode(name)
    }
    
    public init(from decoder: Decoder) throws {
        let container: SingleValueDecodingContainer = try decoder.singleValueContainer()
        self.name = try container.decode(String.self)
    }
}
