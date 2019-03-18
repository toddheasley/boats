import XCTest
import BoatsKit
@testable import BoatsBot

class ComplicationTests: XCTestCase {
    func testDate() {
        var date: Date = Calendar.current.startOfDay(for: Date())
        XCTAssertNotNil(Complication(day: Day(date: date), departure: Departure(time: Time(hour: 16, minute: 20)), destination: .peaks, origin: .portland).date)
        date = Calendar.current.startOfDay(for: Date(timeInterval: 129600.0, since: date))
        XCTAssertNotNil(Complication(day: Day(date: date), departure: Departure(time: Time(hour: 16, minute: 20)), destination: .peaks, origin: .portland).date)
        date = Calendar.current.startOfDay(for: Date(timeInterval: 129600.0, since: date))
        XCTAssertNil(Complication(day: Day(date: date), departure: Departure(time: Time(hour: 16, minute: 20)), destination: .peaks, origin: .portland).date)
    }
    
    func testIsExpired() {
        
    }
}
