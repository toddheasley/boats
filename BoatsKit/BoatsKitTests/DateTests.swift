//
// © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class DateTests: XCTestCase {
    
}

extension DateTests {
    func testDay() {
        XCTAssertEqual(Date(timeIntervalSince1970: 1510576500.0).day(timeZone: TimeZone(secondsFromGMT: -18000)!), DateInterval(start: Date(timeIntervalSince1970: 1510549200.0), end: Date(timeIntervalSince1970: 1510635600.0)))
    }
}
