import Foundation

public protocol CustomAccessibilityStringConvertible: CustomStringConvertible {
    var accessibilityDescription: String { get }
}

extension CustomAccessibilityStringConvertible {
    public var accessibilityDescription: String { description }
}

extension String {
    func find(_ pattern: Self) -> [Self] {
        guard let expression: NSRegularExpression = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive, .dotMatchesLineSeparators]) else {
            return []
        }
        return expression.matches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, count)).map{ result in
            return ((self as NSString).substring(with: result.range(at: 1)))
        }
    }
    
    func stripHTML() -> Self {
        guard let expression: NSRegularExpression = try? NSRegularExpression(pattern: "<[^>]*>", options: [.caseInsensitive, .dotMatchesLineSeparators]) else {
            return ""
        }
        return expression.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: "")
    }
    
    func trim() -> Self {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
