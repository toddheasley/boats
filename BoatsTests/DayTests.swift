//
//  DayTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class DayTests: XCTestCase {
    func testDateDecoding() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        guard let date = dateFormatter.date(from: "Thursday") else {
            XCTFail()
            return
        }
        XCTAssertEqual(Day(date: date), Day.thursday)
    }
}
