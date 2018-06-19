import Foundation
import BoatsKit

enum SVG: String, CaseIterable {
    case menu = "Menu"
    case car = "Car"
}

extension SVG: HTMLConvertible {
    
    // MARK: HTMLConvertible
    var html: HTML {
        guard let data: Data = try? data(),
            let string: String = String(data: data, encoding: .utf8) else {
            return HTML(stringLiteral: "\(rawValue)")
        }
        return HTML(stringLiteral: string.components(separatedBy: "\n").map { string in
            string.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " xmlns=\"http://www.w3.org/2000/svg\"", with: "")
        }.joined())
    }
}

extension SVG: DataEncoding {
    
    // MARK: DataEncoding
    private class SVGClass {
        
    }
    
    func data() throws -> Data {
        guard let url: URL = Bundle(for: type(of: SVGClass())).url(forResource: "\(rawValue)", withExtension: "svg") else {
            throw NSError(domain: NSURLErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        return try Data(contentsOf: url)
    }
}

extension SVG: DataResource, DataWriting, DataDeleting {
    
    // MARK: DataResource
    public var uri: URI {
        return URI(resource: "\(rawValue.lowercased())", type: "svg")
    }
}
