import Foundation

public struct Schedule: Sendable, Codable {
    public let season: Season
    public let timetables: [Timetable]
    
    public var isExpired: Bool { Date() > season.dateInterval.end }
    
    public func timetable(for day: Day = Day()) -> Timetable? {
        for timetable in timetables {
            guard timetable.days.contains(day) else {
                continue
            }
            return timetable
        }
        return nil
    }
}

extension Schedule: Comparable {
    
    // MARK: Comparable
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.season.dateInterval == rhs.season.dateInterval
    }
    
    public static func <(lhs: Self, rhs: Self) -> Bool {
        lhs.season.dateInterval.start < rhs.season.dateInterval.start
    }
}

extension Schedule: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        guard let schedule: String = html.find("<article[^>]*>(.*?)</article>").first, !schedule.isEmpty,
            let season: String = schedule.find("<strong>Currently Displaying:(.*?)</p>").first else {
            throw HTML.error(Self.self, from: html)
        }
        let timetables: [Timetable] = try schedule.find("<table id[^>]*>(.*?)</table>").map { timetable in
            return try Timetable(from: timetable)
        }
        self.init(season: try Season(from: season), timetables: timetables)
    }
}
