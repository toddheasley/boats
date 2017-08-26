//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class DateFormatterTests: XCTestCase {
    
}

extension DateFormatterTests {
    func testLocalization() {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/Vancouver")
        dateFormatter.locale = Locale(identifier: "en_CA")
        XCTAssertEqual(dateFormatter.localization.timeZone.identifier, "America/Vancouver")
        XCTAssertEqual(dateFormatter.localization.locale.identifier, "en_CA")
        XCTAssertEqual(DateFormatter(localization: dateFormatter.localization).timeZone.identifier, "America/Vancouver")
        XCTAssertEqual(DateFormatter(localization: dateFormatter.localization).locale.identifier, "en_CA")
    }
}

extension DateFormatterTests {
    func testTime() {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/New_York")
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        XCTAssertEqual(dateFormatter.string(from: Time(timeInterval: 69600.0 + dateFormatter.timeZone.daylightSavingTimeOffset())), (dateFormatter.is24HourTime ? "16:20" : "4:20."))
        XCTAssertEqual(dateFormatter.string(from: Time(timeInterval: 26400.0 + dateFormatter.timeZone.daylightSavingTimeOffset())), (dateFormatter.is24HourTime ? "04:20" : "4:20"))
        XCTAssertEqual(dateFormatter.dateFormat, "MM/dd/yyyy")
        XCTAssertEqual(dateFormatter.components(from: Time(timeInterval: 69600.0 + dateFormatter.timeZone.daylightSavingTimeOffset())), (dateFormatter.is24HourTime ? ["1", "6", ":", "2", "0", " "] : [" ", "4", ":", "2", "0", "."]))
        XCTAssertEqual(dateFormatter.components(from: Time(timeInterval: 26400.0 + dateFormatter.timeZone.daylightSavingTimeOffset())), (dateFormatter.is24HourTime ? ["0", "4", ":", "2", "0", " "] : [" ", "4", ":", "2", "0", " "]))
        XCTAssertEqual(dateFormatter.dateFormat, "MM/dd/yyyy")
    }
    
    func testDay() {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/New_York")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        XCTAssertEqual(dateFormatter.day(from: Date(timeIntervalSince1970: 1503118598.0)), Day.saturday)
        XCTAssertEqual(dateFormatter.dateFormat, "MM/dd/yyyy")
    }
}
