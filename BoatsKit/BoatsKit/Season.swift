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
        let dateIntervalFormatter: DateIntervalFormatter = DateIntervalFormatter()
        dateIntervalFormatter.timeZone = .shared
        dateIntervalFormatter.timeStyle = .none
        dateIntervalFormatter.dateStyle = .medium
        return "\(name): \(dateIntervalFormatter.string(from: dateInterval) ?? "")".trimmingCharacters(in: .whitespaces)
    }
}
