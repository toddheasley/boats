import XCTest
@testable import BoatsKit

class DayTests: XCTestCase {
    
}

extension DayTests {
    
}

/*
class DayTests: XCTestCase {
    func testDate() {
        let date: Date = Date()
        XCTAssertEqual(Day.special(date).date, date)
        for day in Day.allCases {
            XCTAssertNil(day.date)
        }
    }
    
    func testLocalization() {
        let localization: Localization = Localization(timeZone: TimeZone(identifier: "America/Los_Angeles")!)
        var holiday: Holiday = Holiday()
        holiday.date = Date()
        XCTAssertEqual(Day(date: holiday.date, localization: localization), DateFormatter(localization: localization).day(from: holiday.date))
        XCTAssertEqual(Day(date: holiday.date, localization: localization, holidays: [
            holiday
        ]), Day.holiday)
    }
}

extension DayTests {
    func testCaseIterable() {
        XCTAssertEqual(Day.allCases.count, 8)
    }
}

extension DayTests {
    func testCodable() {
        guard let data1: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Day.self, from: data(for: .mock, type: "json") ?? Data())),
            let day1: Day = try? JSON.decoder.decode(Day.self, from: data1) else {
            XCTFail()
            return
        }
        XCTAssertEqual(day1, Day.special(Date()))
        XCTAssertEqual(day1.date, Date(timeIntervalSince1970: 1514692800.0))
        guard let data2: Data = try? JSON.encoder.encode(Day.wednesday),
            let day2: Day = try? JSON.decoder.decode(Day.self, from: data2) else {
            XCTFail()
            return
        }
        XCTAssertEqual(day2, Day.wednesday)
        XCTAssertNil(day2.date)
    }
}

extension DayTests {
    func testRawRepresentable() {
        let date: Date = Date()
        XCTAssertEqual(Day(rawValue: "wednesday"), Day.wednesday)
        XCTAssertEqual(Day(rawValue: "holiday"), Day.holiday)
        XCTAssertEqual(Day(rawValue: "special", date: date), Day.special(date))
        XCTAssertNil(Day(rawValue: "special"))
    }
}

extension DayTests {
    func testEquatable() {
        XCTAssertEqual(Day.special(Date()), Day.special(Date()))
        XCTAssertNotEqual(Day.special(Date()), Day.wednesday)
        XCTAssertEqual(Day.wednesday, Day.wednesday)
        XCTAssertNotEqual(Day.wednesday, Day.thursday)
    }
} */
