import Foundation
import BoatsKit

protocol HTMLConvertible {
    func html() throws -> String
}

protocol HTMLDataSource {
    func template(of name: String, at index: [Int]) -> String?
    func count(of name: String, at index: [Int]) -> Int
}

struct HTML: HTMLConvertible {
    private(set) var template: String
    var dataSource: HTMLDataSource?
    
    init(template: String) {
        self.template = template
    }
    
    // MARK: HTMLConvertible
    func html() throws -> String {
        return try populate(template: template)
    }
    
    private func populate(template: String, at i: [Int] = []) throws -> String {
        guard let dataSource: HTMLDataSource = dataSource else {
            throw(NSError(domain: NSCocoaErrorDomain, code: NSFeatureUnsupportedError))
        }
        var string: String = "\(template)"
        for match in try! NSRegularExpression(pattern: "<!-- ([A-Z0-9_]*)\\b\\[ -->\n((.|\n)*)\n<!-- ]\\1 -->").matches(in: template, range: NSRange(template.startIndex..., in: template)) {
            var strings: [String] = []
            for ii in 0...(dataSource.count(of: "\(template[Range(match.range(at: 1), in: template)!])", at: i)) {
                guard ii > 0 else {
                    continue
                }
                strings.append(try populate(template: "\(template[Range(match.range(at: 2), in: template)!])", at: i + [(ii - 1)]))
            }
            string = string.replacingOccurrences(of: "\(template[Range(match.range(at: 0), in: template)!])", with: strings.joined(separator: "\n"))
        }
        for match in try! NSRegularExpression(pattern: "<!-- ([A-Z0-9_]*)\\b\\? -->((.|\n)*)<!-- \\?\\1 -->").matches(in: template, range: NSRange(template.startIndex..., in: template)) {
            var strings: [String] = []
            if let _: String = dataSource.template(of: "\(template[Range(match.range(at: 1), in: template)!])", at: i) {
                strings.append(try populate(template: "\(template[Range(match.range(at: 2), in: template)!])", at: i))
            }
            string = string.replacingOccurrences(of: "\(template[Range(match.range(at: 0), in: template)!])", with: strings.joined())
        }
        for match in try! NSRegularExpression(pattern: "<!-- ([A-Z0-9_]*)\\b -->").matches(in: template, range: NSRange(template.startIndex..., in: template)) {
            string = string.replacingOccurrences(of: "\(template[Range(match.range(at: 0), in: template)!])", with: dataSource.template(of: "\(template[Range(match.range(at: 1), in: template)!])", at: i) ?? "")
        }
        return string.replacingOccurrences(of: "\n\n", with: "\n")
    }
}

extension HTML {
    init(data: Data) throws {
        guard let template: String = String(data: data, encoding: .utf8) else {
            throw(NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownStringEncodingError))
        }
        self.template = template
    }
    
    func data() throws -> Data {
        guard let data: Data = (try html()).data(using: .utf8) else {
            throw(NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownStringEncodingError))
        }
        return data
    }
}
