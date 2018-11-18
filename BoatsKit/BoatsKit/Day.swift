import Foundation

public enum Day: String, CaseIterable, Codable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday, holiday
}

extension Day: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(rawValue.capitalized)"
    }
}
