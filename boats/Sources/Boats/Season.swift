import Foundation

public struct Season: Codable, CustomStringConvertible {
    public enum Name: String, CaseIterable, Codable, CustomStringConvertible {
        case spring, summer, fall, winter
        
        // MARK: CustomStringConvertible
        public var description: String {
            return rawValue.capitalized
        }
    }
    
    public let name: Name
    public let dateInterval: DateInterval
    
    init(_ name: Name, dateInterval: DateInterval) {
        self.name = name
        self.dateInterval = dateInterval
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(name): \(DateFormatter.shared.description(from: dateInterval))"
    }
}

extension Season: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        DateFormatter.shared.dateFormat = "MMM d, yyyy"
        let components: [String] = html.stripHTML().components(separatedBy: "\n").compactMap { component in
            let component: String = component.trimmingCharacters(in: .whitespacesAndNewlines)
            return !component.isEmpty && !component.hasSuffix(":") ? component : nil
        }
        guard components.count > 1,
            let rawValue: String = components[0].components(separatedBy: ":").last?.trim().components(separatedBy: " ").first?.lowercased(),
            let name: Name = Name(rawValue: rawValue) else {
            throw HTML.error(Self.self, from: html)
        }
        guard let dateInterval: [String] = components[1].replacingOccurrences(of: "*", with: "").components(separatedBy: ":").last?.replacingOccurrences(of: "&#8211;", with: "-").replacingOccurrences(of: "–", with: "-").components(separatedBy: "-"), dateInterval.count == 2,
            let start: Date = DateFormatter.shared.date(from: dateInterval[0].trim()),
            let end: Date = DateFormatter.shared.date(from: dateInterval[1].trim()), start < end else {
            throw HTML.error(Self.self, from: html)
        }
        var calendar: Calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .shared
        self.init(name, dateInterval: DateInterval(start: start, end: Date(timeInterval: -1.0, since: calendar.startOfDay(for: Date(timeInterval: 129600.0, since: end)))))
    }
}
