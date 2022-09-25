import Foundation

public struct Holiday: Codable {
    public let name: String
    public let date: Date
    
    init(_ name: String, date: Date) {
        self.name = name
        self.date = date
    }
}

extension Holiday: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(name): \(DateFormatter.shared.description(from: date))"
    }
}

extension Holiday: Equatable {
    
    // MARK: Equatable
    public static func ==(x: Self, y: Self) -> Bool {
        return x.date == y.date
    }
}

extension Holiday: CaseIterable {
    public static var memorial: Self {
        return Self("Memorial Day", date: DateFormatter.shared.next(in: [
            (2023, 5, 29),
            (2024, 5, 27),
            (2025, 5, 26)
        ]))
    }
    
    public static var independence: Self {
        return Self("Independence Day", date: DateFormatter.shared.next(month: 7, day: 4))
    }
    
    public static var labor: Self {
        return Self("Labor Day", date: DateFormatter.shared.next(in: [
            (2023, 9, 4),
            (2024, 9, 2),
            (2024, 9, 1)
        ]))
    }
    
    public static var columbus: Self {
        return Self("Columbus Day", date: DateFormatter.shared.next(in: [
            (2023, 10, 9),
            (2024, 10, 14),
            (2025, 10, 13)
        ]))
    }
    
    public static var veterans: Self {
        return Self("Veterans Day", date: DateFormatter.shared.next(month: 11, day: 11))
    }
    
    public static var thanksgiving: Self {
        return Self("Thanksgiving", date: DateFormatter.shared.next(in: [
            (2022, 11, 24),
            (2023, 11, 23),
            (2024, 11, 28)
        ]))
    }
    
    public static var christmas: Self {
        return Self("Christmas Day", date: DateFormatter.shared.next(month: 12, day: 25))
    }
    
    public static var newYears: Self {
        return Self("New Year's Day", date: DateFormatter.shared.next(month: 1, day: 1))
    }
    
    // MARK: CaseIterable
    public static let allCases: [Self] = [.memorial, .independence, .labor, .columbus, .veterans, .thanksgiving, .christmas, .newYears]
}
