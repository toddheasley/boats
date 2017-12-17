import XCTest
@testable import BoatsKit

class ScheduleTests: XCTestCase {
    func testDecodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Schedule.self, from: data(for: .mock, type: "json") ?? Data())),
            let schedule: Schedule = try? JSON.decoder.decode(Schedule.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(schedule.season.dateInterval, DateInterval(start: Date(timeIntervalSince1970: 1498881600.0), duration: 2592000))
        XCTAssertEqual(schedule.holidays.count, 1)
        XCTAssertEqual(schedule.departures.count, 3)
    }
    
    func testDays() {
        guard let schedule: Schedule = try? JSON.decoder.decode(Schedule.self, from: data(for: .mock, type: "json") ?? Data()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(schedule.days, [Day.monday, Day.friday, Day.saturday, Day.holiday])
    }
    
    func testContainsDay() {
        guard let schedule: Schedule = try? JSON.decoder.decode(Schedule.self, from: data(for: .mock, type: "json") ?? Data()) else {
            XCTFail()
            return
        }
        XCTAssertFalse(schedule.contains(day: .wednesday))
        XCTAssertTrue(schedule.contains(day: .holiday))
    }
    
    func testDepartures() {
        guard let schedule: Schedule = try? JSON.decoder.decode(Schedule.self, from: data(for: .mock, type: "json") ?? Data()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(schedule.departures(day: .friday, direction: .destination).count, 1)
        XCTAssertEqual(schedule.departures(day: .friday, direction: .origin).count, 0)
        XCTAssertEqual(schedule.departures(day: .monday, direction: .destination).count, 0)
        XCTAssertEqual(schedule.departures(day: .monday, direction: .origin).count, 1)
    }
    
    func testNext() {
        guard let schedule: Schedule = try? JSON.decoder.decode(Schedule.self, from: data(for: .mock, type: "json") ?? Data()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(schedule.next(day: .holiday, time: Time(timeInterval: 64800.0))?.time, Time(timeInterval: 66600.0))
        XCTAssertNotNil(schedule.next(day: .monday, time: Time(timeInterval: 35999.0), direction: .origin))
        XCTAssertNil(schedule.next(day: .saturday, time: Time(timeInterval: 35999.0), direction: .origin))
        XCTAssertNil(schedule.next(day: .monday, time: Time(timeInterval: 36001.0), direction: .origin))
        XCTAssertNil(schedule.next(day: .monday, time: Time(timeInterval: 35999.0), direction: .destination))
    }
}
