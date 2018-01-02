import Foundation
import BoatsKit

protocol HTMLDataSource {
    func value(of name: String, at index: Int?, in html: HTML) -> String?
    func count(of name: String, in html: HTML) -> Int
}

class HTML: ExpressibleByStringLiteral, CustomStringConvertible {
    private var value: String = ""
    var dataSource: HTMLDataSource?
    
    // MARK: ExpressibleByStringLiteral
    required init(stringLiteral value: String) {
        self.value = value
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        guard let dataSource = dataSource else {
            return value
        }
        var string: String = "\(value)"
        for match in try! NSRegularExpression(pattern: "<!-- (.*)\\b\\[ -->\n(.*)\n<!-- ] -->").matches(in: value, range: NSRange(value.startIndex..., in: value)) {
            var strings: [String] = []
            for index in 0...(dataSource.count(of: "\(value[Range(match.range(at: 1), in: value)!])", in: self)) {
                guard index > 0 else {
                    continue
                }
                strings.append(populate(value: "\(value[Range(match.range(at: 2), in: value)!])", at: index - 1, data: dataSource))
            }
            string = string.replacingOccurrences(of: "\(value[Range(match.range(at: 0), in: value)!])", with: strings.joined(separator: "\n"))
        }
        for match in try! NSRegularExpression(pattern: "<!-- (.*)\\b\\? -->\n(.*)\n<!-- \\? -->").matches(in: value, range: NSRange(value.startIndex..., in: value)) {
            var strings: [String] = []
            if let _ = dataSource.value(of: "\(value[Range(match.range(at: 1), in: value)!])", at: nil, in: self) {
                strings.append(populate(value: "\(value[Range(match.range(at: 2), in: value)!])", at: nil, data: dataSource))
            }
            string = string.replacingOccurrences(of: "\(value[Range(match.range(at: 0), in: value)!])", with: strings.joined())
        }
        return populate(value: string, data: dataSource).replacingOccurrences(of: "\n\n", with: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func populate(value: String, at index: Int? = nil, data source: HTMLDataSource) -> String {
        var string: String = "\(value)"
        for match in try! NSRegularExpression(pattern: "<!-- (.*)\\b -->").matches(in: value, range: NSRange(value.startIndex..., in: value)) {
            string = string.replacingOccurrences(of: "\(value[Range(match.range(at: 0), in: value)!])", with: source.value(of: "\(value[Range(match.range(at: 1), in: value)!])", at: index, in: self) ?? "")
        }
        return string
    }
}
