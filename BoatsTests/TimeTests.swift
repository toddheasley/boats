//
//  TimeTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class TimeTests: XCTestCase {
    func testJSONEncoding() {
        XCTAssertEqual(Time(JSON: "19:45")?.JSON as? String, "19:45")
    }
    
    func testJSONDecoding() {
        XCTAssertEqual(Time(JSON: "19:45")?.hour, 19)
        XCTAssertEqual(Time(JSON: "19:45")?.minute, 45)
        XCTAssertEqual(Time(JSON: "24:60")?.hour, 23)
        XCTAssertEqual(Time(JSON: "24:60")?.minute, 59)
        XCTAssertTrue(Time(JSON: "12") == nil)
        XCTAssertTrue(Date(JSON: "12:34:56") == nil)
    }
    
    func testDateDecoding() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        guard let date = dateFormatter.date(from: "12:00") else {
            XCTFail()
            return
        }
        XCTAssertEqual(Time(date: date), Time(hour: 12, minute: 0))
    }
    
    func testComparable() {
        XCTAssertTrue(Time(JSON: "20:35") == Time(JSON: "20:35"))
        XCTAssertTrue(Time(JSON: "11:21")! < Time(JSON: "11:22")!)
        XCTAssertTrue(Time(JSON: "17:00")! >= Time(JSON: "11:22")!)
        XCTAssertTrue(Time(JSON: "17:00")! >= Time(JSON: "17:00")!)
    }
}
