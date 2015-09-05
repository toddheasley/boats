//
//  HolidayTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest

class HolidayTests: XCTestCase {
    let JSON: [String: String] = [
        "name": "Name",
        "date": "2016-07-04"
    ]
    
    func testJSONDecoding() {
        XCTAssertEqual(Holiday(JSON: JSON)?.name, "Name")
        XCTAssertEqual(Holiday(JSON: JSON)?.date.year, 2016)
        XCTAssertEqual(Holiday(JSON: JSON)?.date.month, 07)
        XCTAssertEqual(Holiday(JSON: JSON)?.date.day, 04)
        XCTAssertTrue(Holiday(JSON: "") == nil)
        XCTAssertTrue(Holiday(JSON: []) == nil)
    }
    
    func testJSONEncoding() {
        XCTAssertEqual(Holiday(JSON: JSON)?.JSON as! [String: String], JSON)
    }
}
