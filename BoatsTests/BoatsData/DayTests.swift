//
//  DayTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class DayTests: XCTestCase {
    func testNSDateDecoding() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        guard let date = dateFormatter.dateFromString("Thursday") else {
            XCTFail()
            return
        }
        XCTAssertEqual(Day(date: date), Day.Thursday)
    }
}
