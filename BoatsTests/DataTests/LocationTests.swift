//
//  LocationTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest

class LocationTests: XCTestCase {
    let JSON: [String: String] = [
        "name": "Name",
        "description": "Description",
        "coordinate": "43.5850105,-70.2315319"
    ]
    
    func testJSONDecoding() {
        XCTAssertEqual(Location(JSON: JSON)?.name, "Name")
        XCTAssertEqual(Location(JSON: JSON)?.description, "Description")
        XCTAssertEqual(Location(JSON: JSON)?.coordinate.latitude, 43.5850105)
        XCTAssertEqual(Location(JSON: JSON)?.coordinate.longitude, -70.2315319)
        XCTAssertTrue(Location(JSON: []) == nil)
    }
    
    func testJSONEncoding() {
        XCTAssertEqual(Location(JSON: JSON)?.JSON as! [String: String], JSON)
    }
}
