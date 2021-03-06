import Foundation

extension String {
    public enum Case {
        case sentence, title
    }
    
    public func capitalized(case: Case = .sentence) -> String {
        switch `case` {
        case .sentence:
            return prefix(1).uppercased() + dropFirst()
        case .title:
            return capitalized(with: Locale(identifier: "en_US"))
        }
    }
    
    public func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func find(_ pattern: String) -> [String] {
        guard let expression: NSRegularExpression = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive, .dotMatchesLineSeparators]) else {
            return []
        }
        return expression.matches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, count)).map{ result in
            return ((self as NSString).substring(with: result.range(at: 1)))
        }
    }
    
    func stripHTML() -> String {
        guard let expression: NSRegularExpression = try? NSRegularExpression(pattern: "<[^>]*>", options: [.caseInsensitive, .dotMatchesLineSeparators]) else {
            return ""
        }
        return expression.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: "")
    }
}
