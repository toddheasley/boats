import Foundation

public struct Schedule: Codable {
    public private(set) var season: Season
    public private(set) var timetables: [Timetable]
    
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
    
    public func current(from date: Date = Date()) -> [Timetable] {
        var day: Day = Day(date: date)
        guard let trips: [Timetable.Trip] = timetable(for: day)?.trips(from: Time(date: date)) else {
            return []
        }
        if trips.count > 1 {
            return [Timetable(trips: Array(trips[0..<2]), days: [day])]
        }
        var timetables: [Timetable] = []
        if let trip: Timetable.Trip = trips.first {
            timetables.append(Timetable(trips: [trip], days: [day]))
        }
        let date: Date = Calendar.current.startOfDay(for: Date(timeInterval: 86400.0, since: date))
        day = Day(date: date)
        if let trips2: [Timetable.Trip] = timetable(for: day)?.trips(from: Time(date: date)), !trips2.isEmpty {
            timetables.append(Timetable(trips: Array(trips2[0..<(timetables.isEmpty ? 2 : 1)]), days: [day]))
        }
        return timetables
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
    
    public init(season: Season, timetables: [Timetable]) {
        self.season = season
        self.timetables = timetables
    }
}

extension Schedule: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        guard let schedule: String = html.find("<article[^>]*>(.*?)</article>").first, !schedule.isEmpty,
            let season: String = schedule.find("<p style=\"text-align: center;\">(.*?)</p>").first else {
            throw(HTML.error(Schedule.self, from: html))
        }
        let timetables: [Timetable] = try schedule.find("<table[^>]*>(.*?)</table>").map { timetable in
            return try Timetable(from: timetable)
        }
        self.init(season: try Season(from: season), timetables: timetables)
    }
}
