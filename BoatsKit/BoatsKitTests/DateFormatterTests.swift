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
        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "America/Vancouver")
        formatter.locale = Locale(identifier: "en_CA")
        XCTAssertEqual(formatter.localization.timeZone.identifier, "America/Vancouver")
        XCTAssertEqual(formatter.localization.locale.identifier, "en_CA")
        XCTAssertEqual(DateFormatter(localization: formatter.localization).timeZone.identifier, "America/Vancouver")
        XCTAssertEqual(DateFormatter(localization: formatter.localization).locale.identifier, "en_CA")
    }
}

extension DateFormatterTests {
    func testDay() {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "America/New_York")
        XCTAssertEqual(formatter.day(from: Date(timeIntervalSince1970: 1503118598.0)), Day.saturday)
    }
}
