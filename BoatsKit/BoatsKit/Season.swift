import Foundation

public struct Season: Codable {
    public enum Name: String, CaseIterable, Codable, CustomStringConvertible {
        case spring, summer, fall, winter
        
        // MARK: CustomStringConvertible
        public var description: String {
            return "\(rawValue.capitalized)"
        }
    }
    
    public private(set) var name: Name
    public private(set) var dateInterval: DateInterval
    
    public init(name: Name, dateInterval: DateInterval) {
        self.name = name
        self.dateInterval = dateInterval
    }
}

extension Season: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(name): \(DateFormatter.shared.description(from: dateInterval))"
    }
}

extension Season: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        DateFormatter.shared.dateFormat = "MMM d, yyyy"
        let components: [String] = html.stripHTML().components(separatedBy: "\n")
        guard components.count > 1,
            let rawValue: String = components[0].components(separatedBy: ":").last?.trim().components(separatedBy: " ").first?.lowercased(),
            let name: Name = Name(rawValue: rawValue),
            let dateInterval: [String] = components[1].components(separatedBy: ":").last?.components(separatedBy: "&#8211;"), dateInterval.count == 2,
            let start: Date = DateFormatter.shared.date(from: dateInterval[0].trim()),
            let end: Date = DateFormatter.shared.date(from: dateInterval[1].trim()), start < end else {
            throw(HTML.error(Season.self, from: html))
        }
        var calendar: Calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .shared
        self.init(name: name, dateInterval: DateInterval(start: start, end: Date(timeInterval: -0.1, since: calendar.startOfDay(for: Date(timeInterval: 129600.0, since: end)))))
    }
}
