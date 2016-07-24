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
    
    func testReloadData() {
        let expectation: XCTestExpectation = self.expectation(description: "")
        UserDefaults.standard.data = nil
        var data = Data()
        data.reloadData { completed in
            expectation.fulfill()
            if (!completed) {
                XCTFail()
                return
            }
            XCTAssertEqual(data.name, "Ferry Schedules")
            XCTAssertEqual(data.description, "Casco Bay Islands")
            XCTAssertEqual(data.providers.count, 2)
            data = Data()
            XCTAssertEqual(data.providers.count, 2)
            UserDefaults.standard.data = nil
        }
        waitForExpectations(timeout: 10.0){ error in
            if let error = error {
                XCTFail("\(error)")
            }
        }
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
