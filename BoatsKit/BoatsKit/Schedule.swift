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
