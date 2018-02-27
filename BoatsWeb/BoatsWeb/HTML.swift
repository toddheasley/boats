import Foundation
import BoatsKit

protocol HTMLDataSource {
    func value(of name: String, at i: [Int], in html: HTML) -> String?
    func count(of name: String, at i: [Int], in html: HTML) -> Int
}

protocol HTMLConvertible {
    var html: HTML {
        get
    }
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
        return populate(value: value).replacingOccurrences(of: "\n\n", with: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func populate(value: String, at i: [Int] = []) -> String {
        guard let dataSource: HTMLDataSource = dataSource else {
            return value
        }
        var string: String = "\(value)"
        for match in try! NSRegularExpression(pattern: "<!-- ([A-Z0-9_]*)\\b\\[ -->\n((.|\n)*)\n<!-- ]\\1 -->").matches(in: value, range: NSRange(value.startIndex..., in: value)) {
            var strings: [String] = []
            for ii in 0...(dataSource.count(of: "\(value[Range(match.range(at: 1), in: value)!])", at: i, in: self)) {
                guard ii > 0 else {
                    continue
                }
                strings.append(populate(value: "\(value[Range(match.range(at: 2), in: value)!])", at: i + [(ii - 1)]))
            }
            string = string.replacingOccurrences(of: "\(value[Range(match.range(at: 0), in: value)!])", with: strings.joined(separator: "\n"))
        }
        for match in try! NSRegularExpression(pattern: "<!-- ([A-Z0-9_]*)\\b\\? -->((.|\n)*)<!-- \\?\\1 -->").matches(in: value, range: NSRange(value.startIndex..., in: value)) {
            var strings: [String] = []
            if let _: String = dataSource.value(of: "\(value[Range(match.range(at: 1), in: value)!])", at: i, in: self) {
                strings.append(populate(value: "\(value[Range(match.range(at: 2), in: value)!])", at: i))
            }
            string = string.replacingOccurrences(of: "\(value[Range(match.range(at: 0), in: value)!])", with: strings.joined())
        }
        for match in try! NSRegularExpression(pattern: "<!-- ([A-Z0-9_]*)\\b -->").matches(in: value, range: NSRange(value.startIndex..., in: value)) {
            string = string.replacingOccurrences(of: "\(value[Range(match.range(at: 0), in: value)!])", with: dataSource.value(of: "\(value[Range(match.range(at: 1), in: value)!])", at: i, in: self) ?? "")
        }
        return string
    }
}
