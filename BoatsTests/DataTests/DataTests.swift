//
//  DataTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest
@testable import Boats

class DataTests: XCTestCase {
    func testRefresh() {
        let expectation: XCTestExpectation = expectationWithDescription("")
        let data: Data = Data(local: false)
        data.refresh(){ error in
            guard let _ = data.JSON as? [String: [AnyObject]] else {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertTrue(data.providers.count > 0)
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
            XCTAssertTrue(localData.providers.count > 0)
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
            XCTAssertTrue((data.JSON as! [String: [AnyObject]])["providers"]?.count > 0)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10.0){ error in
            if let error = error {
                XCTFail("\(error)")
            }
        }
    }
}
