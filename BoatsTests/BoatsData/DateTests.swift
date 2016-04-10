//
//  DateTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class DateTests: XCTestCase {
    func testJSONEncoding() {
        XCTAssertEqual(Date(JSON: "2016-07-04")?.JSON as? String, "2016-07-04")
    }
    
    func testJSONDecoding() {
        XCTAssertEqual(Date(JSON: "2016-07-04")?.year, 2016)
        XCTAssertEqual(Date(JSON: "2016-07-04")?.month, 7)
        XCTAssertEqual(Date(JSON: "2016-07-04")?.day, 4)
        XCTAssertEqual(Date(JSON: "2013-00-00")?.year, 2016)
        XCTAssertEqual(Date(JSON: "2013-00-00")?.month, 1)
        XCTAssertEqual(Date(JSON: "2013-00-00")?.day, 1)
        XCTAssertEqual(Date(JSON: "3000-13-32")?.year, 3000)
        XCTAssertEqual(Date(JSON: "3000-13-32")?.month, 12)
        XCTAssertEqual(Date(JSON: "3000-13-32")?.day, 31)
        XCTAssertEqual(Date(JSON: "2020-02-31")?.day, 29)
        XCTAssertEqual(Date(JSON: "2021-02-31")?.day, 28)
        XCTAssertTrue(Date(JSON: "") == nil)
        XCTAssertTrue(Date(JSON: "1234-5-67-89") == nil)
        XCTAssertTrue(Date(JSON: "1234-5") == nil)
    }
    
    func testNSDateDecoding() {
        
    }
    
    func testComparable() {
        XCTAssertTrue(Date(JSON: "2016-07-25") == Date(JSON: "2016-07-25"))
        XCTAssertTrue(Date(JSON: "2017-01-01") < Date(JSON: "2017-01-02"))
        XCTAssertTrue(Date(JSON: "2016-07-25") >= Date(JSON: "2016-07-25"))
    }
}
