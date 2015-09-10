//
//  TimeTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest

class TimeTests: XCTestCase {
    func testValue() {
        XCTAssertEqual(Time(JSON: "20:35")?.value, 2035)
    }
    
    func testJSONDecoding() {
        XCTAssertEqual(Time(JSON: "19:45")?.hour, 19)
        XCTAssertEqual(Time(JSON: "19:45")?.minute, 45)
        XCTAssertEqual(Time(JSON: "24:60")?.hour, 23)
        XCTAssertEqual(Time(JSON: "24:60")?.minute, 59)
        XCTAssertTrue(Time(JSON: "12") == nil)
        XCTAssertTrue(Date(JSON: "12:34:56") == nil)
    }
    
    func testJSONEncoding() {
        XCTAssertEqual(Time(JSON: "19:45")?.JSON as? String, "19:45")
    }
}
