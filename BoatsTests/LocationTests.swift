//
//  LocationTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class LocationTests: XCTestCase {
    func testJSONEncoding() {
        guard let mockJSON = mockJSON, let location = Location(JSON: mockJSON), let JSON = location.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual(JSON["name"] as? String, "Portland")
        XCTAssertEqual(JSON["description"] as? String, "Casco Bay Lines Ferry Terminal")
        XCTAssertEqual(JSON["coordinate"] as? String, "43.6570177,-70.248711")
    }
    
    func testJSONDecoding() {
        guard let mockJSON = mockJSON, let location = Location(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertEqual(location.name, "Portland")
        XCTAssertEqual(location.description, "Casco Bay Lines Ferry Terminal")
        XCTAssertEqual(location.coordinate.latitude, 43.6570177)
        XCTAssertEqual(location.coordinate.longitude, -70.248711)
    }
}
