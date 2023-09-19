import Foundation
import Boats

extension Route {
    public func schedules(from date: Date = Date()) -> [Schedule] {
        return schedules.filter { schedule in
            return date < schedule.season.dateInterval.end
        }
    }
}
