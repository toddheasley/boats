import Foundation
import Boats

extension Route {
    public func schedules(from date: Date = Date()) -> [Schedule] {
        schedules.filter { date < $0.season.dateInterval.end }
    }
}
