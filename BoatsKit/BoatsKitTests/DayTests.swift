//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class DayTests: XCTestCase {
    func testDate() {
        let date: Date = Date()
        XCTAssertEqual(Day.special(date).date, date)
        for day in Day.all {
            XCTAssertNil(day.date)
        }
    }
}

extension DayTests {
    func testCodable() {
        guard let data1: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Day.self, from: data ?? Data())),
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
    func testEquatable() {
        XCTAssertEqual(Day.special(Date()), Day.special(Date()))
        XCTAssertNotEqual(Day.special(Date()), Day.wednesday)
        XCTAssertEqual(Day.wednesday, Day.wednesday)
        XCTAssertNotEqual(Day.wednesday, Day.thursday)
    }
}
