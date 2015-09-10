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
        let expectation: XCTestExpectation = expectationWithDescription("")
        let data: Data = Data(local: true)
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
        let expectation: XCTestExpectation = expectationWithDescription("")
        let data: Data = Data(local: false)
        data.refresh(){ error in
            guard let _ = data.JSON as? [String: [AnyObject]] else {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertTrue(data.routes.count > 0)
            expectation.fulfill()
        }
        let localExpectation: XCTestExpectation = expectationWithDescription("Local")
        let localData: Data = Data(local: true)
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
        let expectation: XCTestExpectation = expectationWithDescription("")
        let data: Data = Data(local: true)
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
