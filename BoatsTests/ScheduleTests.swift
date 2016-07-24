//
//  ScheduleTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class ScheduleTests: XCTestCase {
    func testDays() {
        guard let mockJSON = mockJSON, let schedule = Schedule(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertEqual(schedule.days, [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday])
    }
    
    func testDepartures() {
        guard let mockJSON = mockJSON, let schedule = Schedule(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertEqual(schedule.departures(day: .saturday).count, 2)
        XCTAssertEqual(schedule.departures(day: .saturday, direction: .destination).count, 1)
        XCTAssertEqual(schedule.departures(day: .sunday, direction: .destination).count, 0)
        XCTAssertEqual(schedule.departures(day: .wednesday, direction: .origin).count, 0)
    }
    
    func testJSONEncoding() {
        guard let mockJSON = mockJSON, let schedule = Schedule(JSON: mockJSON), let JSON = schedule.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual(JSON["season"] as? String, Season.spring.rawValue)
        XCTAssertEqual(JSON["dates"] as? String, "2016-04-16,2016-06-17")
        XCTAssertEqual((JSON["holidays"] as? [AnyObject])?.count, 1)
        XCTAssertEqual((JSON["departures"] as? [AnyObject])?.count, 2)
    }
    
    func testJSONDecoding() {
        guard let mockJSON = mockJSON, let schedule = Schedule(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertEqual(schedule.season.rawValue, Season.spring.rawValue)
        XCTAssertEqual(schedule.dates.start, Date(JSON: "2016-04-16"))
        XCTAssertEqual(schedule.dates.end, Date(JSON: "2016-06-17"))
        XCTAssertEqual(schedule.holidays.count, 1)
        XCTAssertEqual(schedule.departures.count, 2)
    }
}
