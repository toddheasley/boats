import Foundation

public enum Day: String, Sendable, CaseIterable, Codable, CustomAccessibilityStringConvertible {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    
    public static let weekdays: [Self] = [.monday, .tuesday, .wednesday, .thursday, .friday]
    
    public static func week(beginning day: Self = Self()) -> [Self] {
        let week: [Self] = Array(allCases[0...6] + allCases[0...6])
        let index: Int = week.firstIndex(of: day)!
        return Array(week[index...(index + 6)])
    }
    
    public init(_ date: Date = Date()) {
        self = DateFormatter.day(from: date)
    }
    
    // MARK: CustomAccessibilityStringConvertible
    public var accessibilityDescription: String { rawValue.capitalized }
    public var description: String { "\(rawValue.capitalized.prefix(3))" }
}

extension Day: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        let html: String = html.trim().lowercased()
        guard html.count > 1 else {
            throw HTML.error(Self.self, from: html)
        }        
        switch html.prefix(2){
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
        default:
            throw HTML.error(Self.self, from: html)
        }
    }
}

extension [Day]: CustomAccessibilityStringConvertible {
    private var ranges: [Self] {
        let indices: [Int] = map { day in
            return Day.allCases.firstIndex(of: day)!
        }.sorted()
        var ranges: [[Int]] = []
        var range: [Int] = []
        
        func flush() {
            if range.count < 3 {
                for index in range {
                    ranges.append([index])
                }
            } else {
                ranges.append(range)
            }
            range = []
        }
        
        for index in indices {
            if index < 7, let last: Int = range.last, index == last + 1 {
                range.append(index)
            } else {
                flush()
                range.append(index)
            }
        }
        flush()
        return ranges.map { $0.map { Day.allCases[$0] } }
    }
    
    // MARK: CustomAccessibilityStringConvertible
    public var accessibilityDescription: String {
        var strings: [String] = []
        for range in ranges {
            if range.count > 1 {
                strings.append("\(range.first!.accessibilityDescription) through \(range.last!.accessibilityDescription)")
            } else {
                strings.append("\(range.first!.accessibilityDescription)")
            }
        }
        return strings.joined(separator: " and ")
        
    }
    
    var description: String {
        var strings: [String] = []
        for range in ranges {
            if range.count > 1 {
                strings.append("\(range.first!)-\(range.last!)")
            } else {
                strings.append("\(range.first!)")
            }
        }
        return strings.joined(separator: "/")
    }
}
