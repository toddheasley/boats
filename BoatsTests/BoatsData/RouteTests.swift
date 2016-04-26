//
//  RouteTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class RouteTests: XCTestCase {
    func testSchedule() {
        guard let mockJSON = mockJSON, route = Route(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertNotNil(route.schedule(Date(JSON: "2016-05-01")!))
        XCTAssertTrue(route.schedule(Date(JSON: "2016-04-01")!) == nil)
        XCTAssertTrue(route.schedule(Date(JSON: "2016-10-15")!) == nil)
    }
    
    func testJSONEncoding() {
        guard let mockJSON = mockJSON, route = Route(JSON: mockJSON), JSON = route.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual(JSON["name"] as? String, "Peaks Island")
        XCTAssertEqual(JSON["code"] as? String, "CBL_PEAKS")
        XCTAssertNotNil(JSON["destination"] as? [String: AnyObject])
        XCTAssertNotNil(JSON["origin"] as? [String: AnyObject])
        XCTAssertEqual((JSON["schedules"] as? [AnyObject])?.count, 1)
    }
    
    func testJSONDecoding() {
        guard let mockJSON = mockJSON, route = Route(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertEqual(route.name, "Peaks Island")
        XCTAssertEqual(route.code, "CBL_PEAKS")
        XCTAssertEqual(route.destination.name, "Peaks Island")
        XCTAssertEqual(route.origin.name, "Portland")
        XCTAssertEqual(route.schedules.count, 1)
    }
}
