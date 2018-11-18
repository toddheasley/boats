import Foundation

public struct Schedule: Codable {
    public private(set) var season: Season
    public private(set) var timetables: [Timetable]
    public private(set) var holidays: [Holiday]
    
    public var today: Day? {
        return nil
    }
    
    public func timetable(for day: Day) -> Timetable? {
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
        
        self.holidays = []
    }
}
