import Foundation

public struct Holiday: Codable {
    public let name: String
    public let date: Date
    
    init(name: String, date: Date) {
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
    public static func ==(x: Holiday, y: Holiday) -> Bool {
        return x.date == y.date
    }
}

extension Holiday: CaseIterable {
    
    // MARK: CaseIterable
    public typealias AllCases = [Holiday]
    
    public static var allCases: AllCases {
        return [.memorial, .independence, .labor, .columbus, .veterans, .thanksgiving, .christmas, .newYears]
    }
}

extension Holiday {
    public static var memorial: Holiday {
        return Holiday(name: "Memorial Day", date: DateFormatter.shared.next(in: [
            (2022, 5, 30)
        ]))
    }
    
    public static var independence: Holiday {
        return Holiday(name: "Independence Day", date: DateFormatter.shared.next(month: 7, day: 4))
    }
    
    public static var labor: Holiday {
        return Holiday(name: "Labor Day", date: DateFormatter.shared.next(in: [
            (2022, 10, 5)
        ]))
    }
    
    public static var columbus: Holiday {
        return Holiday(name: "Columbus Day", date: DateFormatter.shared.next(in: [
            (2022, 10, 10)
        ]))
    }
    
    public static var veterans: Holiday {
        return Holiday(name: "Veterans Day", date: DateFormatter.shared.next(month: 11, day: 11))
    }
    
    public static var thanksgiving: Holiday {
        return Holiday(name: "Thanksgiving", date: DateFormatter.shared.next(in: [
            (2022, 11, 24)
        ]))
    }
    
    public static var christmas: Holiday {
        return Holiday(name: "Christmas Day", date: DateFormatter.shared.next(month: 12, day: 25))
    }
    
    public static var newYears: Holiday {
        return Holiday(name: "New Year's Day", date: DateFormatter.shared.next(month: 1, day: 1))
    }
}
