import Foundation

public enum Day: String, CaseIterable, Codable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday, holiday
    
    public static func week(beginning day: Self = Self()) -> [Self] {
        let week: [Self] = Array(allCases[0...6] + allCases[0...6])
        let index: Int = week.firstIndex(of: day != .holiday ? day : Self())!
        return Array(week[index...(index + 6)])
    }
    
    public init(_ date: Date = Date()) {
        self = DateFormatter.shared.day(from: date)
    }
}

extension Day: CustomStringConvertible {
    public var abbreviated: String {
        return "\(description[...rawValue.index(rawValue.startIndex, offsetBy: 2)])"
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return rawValue.capitalized
    }
}

extension Day: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        let html: String = html.trim().lowercased()
        guard html.count > 1 else {
            throw HTML.error(Self.self, from: html)
        }        
        switch html[..<html.index(html.startIndex, offsetBy: 2)]{
        case "mo":
            self = .monday
        case "tu":
            self = .tuesday
        case "we":
            self = .wednesday
        case "th":
            self = .thursday
        case "fr":
            self = .friday
        case "sa":
            self = .saturday
        case "su":
            self = .sunday
        case "ho":
            self = .holiday
        default:
            throw HTML.error(Self.self, from: html)
        }
    }
}