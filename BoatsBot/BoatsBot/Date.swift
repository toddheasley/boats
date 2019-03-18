import Foundation
import BoatsKit

extension Date {
    init?(day: Day, time: Time, matching date: Date = Date()) {
        let date: Date = Calendar.current.startOfDay(for: date)
        guard Day(date: date) == day else {
            return nil
        }
        var components: DateComponents = DateComponents()
        components.hour = time.components.hour
        components.minute = time.components.minute
        guard let nextDate: Date = Calendar.current.nextDate(after: date, matching: components, matchingPolicy: .nextTime) else {
            return nil
        }
        self = nextDate
    }
}
