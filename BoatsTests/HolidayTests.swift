//
//  HolidayTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class HolidayTests: XCTestCase {
    func testJSONEncoding() {
        guard let mockJSON = mockJSON, let holiday = Holiday(JSON: mockJSON), let JSON = holiday.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual(JSON["name"] as? String, "Independence Day")
        XCTAssertEqual(JSON["date"] as? String, "2016-07-04")
    }
    
    func testJSONDecoding() {
        guard let mockJSON = mockJSON, let holiday = Holiday(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertEqual(holiday.name, "Independence Day")
        XCTAssertEqual(holiday.date.year, 2016)
        XCTAssertEqual(holiday.date.month, 07)
        XCTAssertEqual(holiday.date.day, 04)
    }
}
