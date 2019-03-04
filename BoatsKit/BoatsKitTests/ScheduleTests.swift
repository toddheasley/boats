import XCTest
@testable import BoatsKit

class ScheduleTests: XCTestCase {
    func testIsExpired() {
        XCTAssertEqual(Schedule(season: Season(name: .spring, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1523678400.0), end: Date(timeIntervalSince1970: 1529121599.9))), timetables: []).isExpired, Date() > Date(timeIntervalSince1970: 1529121599.9))
        XCTAssertEqual(Schedule(season: Season(name: .winter, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1539057600), end: Date(timeIntervalSince1970: 1546664399.9))), timetables: []).isExpired, Date() > Date(timeIntervalSince1970: 1546664399.9))
    }
    
    func testCurrent() {
        
    }
    
    func testTimetable() {
        let schedule: Schedule = Schedule(season: Season(name: .summer, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))), timetables: [
            Timetable(trips: [Timetable.Trip()], days: [.monday, .tuesday, .wednesday, .thursday]),
            Timetable(trips: [Timetable.Trip(), Timetable.Trip()], days: [.friday, .saturday])
        ])
        XCTAssertEqual(schedule.timetable(for: .saturday)?.trips.count, 2)
        XCTAssertEqual(schedule.timetable(for: .tuesday)?.trips.count, 1)
    }
}

extension ScheduleTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() {
        guard let data: Data = data(resource: .bundle, type: "html"),
            let html: String = String(data: data, encoding: .utf8), !html.isEmpty else {
            XCTFail()
            return
        }
        XCTAssertEqual(try? Schedule(from: html).season.name, .winter)
        XCTAssertEqual(try? Schedule(from: html).timetables.count, 4)
    }
}
