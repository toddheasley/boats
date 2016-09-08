//
//  DataTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class DataTests: XCTestCase {
    func testProvider() {
        guard let mockJSON = mockJSON, let data = Data(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertNotNil(data.provider(code: "CBL"))
        XCTAssertNotNil(data.provider(code: "CTC"))
        XCTAssertNil(data.provider(code: "#"))
    }
    
    func testJSONEncoding() {
        guard let mockJSON = mockJSON, let data = Data(JSON: mockJSON), let JSON = data.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual((JSON["name"] as? String), "Ferry Schedules")
        XCTAssertEqual((JSON["description"] as? String), "Casco Bay Islands")
        XCTAssertEqual((JSON["providers"] as? [AnyObject])?.count, 2)
        XCTAssertEqual((JSON["zone"] as? String), "America/New_York")
    }
    
    func testJSONDecoding() {
        guard let mockJSON = mockJSON, let data = Data(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertEqual(data.providers.count, 2)
    }
}
