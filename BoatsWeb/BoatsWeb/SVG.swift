import Foundation
import BoatsKit

enum SVG: String, CaseIterable {
    case menu, car
}

extension SVG: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(rawValue)"
    }
}

extension SVG: Resource {
    
    // MARK: Resource
    public var path: String {
        return "\(rawValue).svg"
    }
    
    public func data() throws -> Data {
        return try Data(contentsOf: try URL.bundle(resource: "\(rawValue.capitalized())", type: "svg"))
    }
}

extension SVG: HTMLConvertible {
    
    // MARK: HTMLConvertible
    func html() throws -> String {
        guard let html: String = String(data: try data(), encoding: .utf8) else {
            throw(NSError(domain: NSCocoaErrorDomain, code: NSFileReadCorruptFileError))
        }
        return html.components(separatedBy: "\n").map { component in
            component.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " xmlns=\"http://www.w3.org/2000/svg\"", with: "")
        }.joined()
    }
}
