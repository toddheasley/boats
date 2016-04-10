//
//  DepartureTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class DepartureTests: XCTestCase {
    func testJSONEncoding() {
        guard let JSONMock = JSONMock, departure = Departure(JSON: JSONMock), JSON = departure.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual((JSON["days"] as? [AnyObject])?.count, 5)
        XCTAssertEqual((JSON["days"] as? [String])!, ["Monday","Tuesday","Wednesday","Thursday","Friday"])
        XCTAssertEqual(JSON["time"] as? String, "06:15")
        XCTAssertEqual(JSON["direction"] as? String, Direction.Origin.rawValue)
        XCTAssertEqual(JSON["cars"] as? Bool, true)
    }
    
    func testJSONDecoding() {
        guard let JSONMock = JSONMock, departure = Departure(JSON: JSONMock) else {
            XCTFail()
            return
        }
        XCTAssertEqual(departure.days.count, 5)
        XCTAssertEqual(departure.time.hour, Time(JSON: "06:15")?.hour)
        XCTAssertEqual(departure.time.minute, Time(JSON: "06:15")?.minute)
        XCTAssertEqual(departure.direction, Direction.Origin)
        XCTAssertEqual(departure.cars, true)
    }
}
