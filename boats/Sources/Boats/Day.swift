import Foundation

public enum Day: String, CaseIterable, Codable, CustomStringConvertible {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    
    public static let weekdays: [Self] = [.monday, .tuesday, .wednesday, .thursday, .friday]
    
    public static func week(beginning day: Self = Self()) -> [Self] {
        let week: [Self] = Array(allCases[0...6] + allCases[0...6])
        let index: Int = week.firstIndex(of: day)!
        return Array(week[index...(index + 6)])
    }
    
    public init(_ date: Date = Date()) {
        self = DateFormatter.shared.day(from: date)
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(rawValue.capitalized.prefix(3))"
    }
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

extension [Day] {
    
    // MARK: CustomStringConvertible
    var description: String {
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
        var strings: [String] = []
        for range in ranges {
            if range.count > 1 {
                strings.append("\(Day.allCases[range.first!])-\(Day.allCases[range.last!])")
            } else {
                strings.append("\(Day.allCases[range.first!])")
            }
        }
        return strings.joined(separator: "/")
    }
}
