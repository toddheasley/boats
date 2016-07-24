//
//  CoordinateTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class CoordinateTests: XCTestCase {
    func testJSONEncoding() {
        XCTAssertEqual(Coordinate(JSON: "43.5850105,-70.2315319")?.JSON as? String, "43.5850105,-70.2315319")
    }
    
    func testJSONDecoding() {
        XCTAssertEqual(Coordinate(JSON: "43.5850105,-70.2315319")?.latitude, 43.5850105)
        XCTAssertEqual(Coordinate(JSON: "43.5850105,-70.2315319")?.longitude, -70.2315319)
        XCTAssertTrue(Coordinate(JSON: "43.5850105") == nil)
        XCTAssertTrue(Coordinate(JSON: "43.5850105,-70.2315319,43.5850105") == nil)
        XCTAssertTrue(Coordinate(JSON: "NaN,NaN") == nil)
    }
}
