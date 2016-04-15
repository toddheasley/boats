//
//  DataTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class DataTests: XCTestCase {
    func testProvider() {
        guard let JSONMock = JSONMock, data = Data(JSON: JSONMock) else {
            XCTFail()
            return
        }
        XCTAssertNotNil(data.provider("CBL"))
        XCTAssertNotNil(data.provider("CTC"))
        XCTAssertNil(data.provider("#"))
    }
    
    func testReloadData() {
        let expectation: XCTestExpectation = expectationWithDescription("")
        NSUserDefaults.standardUserDefaults().data = nil
        var data = Data()
        data.reloadData { completed in
            expectation.fulfill()
            if (!completed) {
                XCTFail()
                return
            }
            XCTAssertEqual(data.providers.count, 2)
            data = Data()
            XCTAssertEqual(data.providers.count, 2)
            NSUserDefaults.standardUserDefaults().data = nil
        }
        waitForExpectationsWithTimeout(10.0){ error in
            if let error = error {
                XCTFail("\(error)")
            }
        }
    }
    
    func testJSONEncoding() {
        guard let JSONMock = JSONMock, data = Data(JSON: JSONMock), JSON = data.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual((JSON["providers"] as? [AnyObject])?.count, 2)
    }
    
    func testJSONDecoding() {
        guard let JSONMock = JSONMock, data = Data(JSON: JSONMock) else {
            XCTFail()
            return
        }
        XCTAssertEqual(data.providers.count, 2)
    }
}
