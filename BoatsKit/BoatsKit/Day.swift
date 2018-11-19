import Foundation

public enum Day: String, CaseIterable, Codable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday, holiday
    
    public init(date: Date = Date()) {
        self = DateFormatter.shared.day(from: date)
    }
}

extension Day: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(rawValue.capitalized)"
    }
}
