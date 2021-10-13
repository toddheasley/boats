import Foundation

public struct Schedule: Codable {
    public let season: Season
    public let timetables: [Timetable]
    
    public var isExpired: Bool {
        return Date() > season.dateInterval.end
    }
    
    public var holidays: [Holiday] {
        var holidays: [Holiday] = []
        for holiday in Holiday.allCases {
            guard season.dateInterval.contains(holiday.date) else {
                continue
            }
            holidays.append(holiday)
        }
        return holidays
    }
    
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

extension Schedule: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        guard let schedule: String = html.find("<article[^>]*>(.*?)</article>").first, !schedule.isEmpty,
            let season: String = schedule.find("<strong>Currently Displaying:(.*?)</p>").first else {
            throw(HTML.error(Schedule.self, from: html))
        }
        let timetables: [Timetable] = try schedule.find("<table id[^>]*>(.*?)</table>").map { timetable in
            return try Timetable(from: timetable)
        }
        self.init(season: try Season(from: season), timetables: timetables)
    }
}
