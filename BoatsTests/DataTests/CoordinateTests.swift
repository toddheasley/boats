//
//  CoordinateTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest

class CoordinateTests: XCTestCase {
    func testJSONDecoding() {
        XCTAssertEqual(Coordinate(JSON: "43.5850105,-70.2315319")?.latitude, 43.5850105)
        XCTAssertEqual(Coordinate(JSON: "43.5850105,-70.2315319")?.longitude, -70.2315319)
        XCTAssertTrue(Coordinate(JSON: "43.5850105") == nil)
        XCTAssertTrue(Coordinate(JSON: "43.5850105,-70.2315319,43.5850105") == nil)
        XCTAssertTrue(Coordinate(JSON: "NaN,NaN") == nil)
    }
    
    func testJSONEncoding() {
        XCTAssertEqual(Coordinate(JSON: "43.5850105,-70.2315319")?.JSON as? String, "43.5850105,-70.2315319")
    }
}
