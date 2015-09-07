//
//  DataTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest
@testable import Boats

class DataTests: XCTestCase {
    func testRoute() {
        let expectation = expectationWithDescription("")
        let data = Data(local: true)
        data.refresh(){ error in
            if (data.routes.count < 1) {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(data.route(data.routes[0].code))
            XCTAssertNil(data.route("#"))
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10.0){ error in
            if let error = error {
                XCTFail("\(error)")
            }
        }
    }
    
    func testRefresh() {
        let expectation = expectationWithDescription("")
        let data = Data(local: false)
        data.refresh(){ error in
            guard let _ = data.JSON as? [String: [AnyObject]] else {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertTrue(data.routes.count > 0)
            expectation.fulfill()
        }
        let localExpectation = expectationWithDescription("Local")
        let localData = Data(local: true)
        localData.refresh(){ error in
            guard let _ = localData.JSON as? [String: [AnyObject]] else {
                XCTFail()
                localExpectation.fulfill()
                return
            }
            XCTAssertTrue(localData.routes.count > 0)
            localExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(10.0){ error in
            if let error = error {
                XCTFail("\(error)")
            }
        }
    }
    
    func testJSONEncoding() {
        let expectation = expectationWithDescription("")
        let data = Data(local: true)
        data.refresh(){ error in
            guard let _ = data.JSON as? [String: [AnyObject]] else {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertTrue((data.JSON as! [String: [AnyObject]])["routes"]?.count > 0)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10.0){ error in
            if let error = error {
                XCTFail("\(error)")
            }
        }
    }
}
