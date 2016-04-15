//
//  ProviderTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class ProviderTests: XCTestCase {
    func testRoute() {
        guard let JSONMock = JSONMock, provider = Provider(JSON: JSONMock) else {
            XCTFail()
            return
        }
        XCTAssertNotNil(provider.route("CBL_PEAKS"))
        XCTAssertNil(provider.route("#"))
    }
    
    func testJSONEncoding() {
        guard let JSONMock = JSONMock, provider = Provider(JSON: JSONMock), JSON = provider.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual(JSON["name"] as? String, "Casco Bay Lines")
        XCTAssertEqual(JSON["code"] as? String, "CBL")
        XCTAssertEqual(JSON["www"] as? String, "http://www.cascobaylines.com")
        XCTAssertEqual((JSON["routes"] as? [AnyObject])?.count, 1)
    }
    
    func testJSONDecoding() {
        guard let JSONMock = JSONMock, provider = Provider(JSON: JSONMock) else {
            XCTFail()
            return
        }
        XCTAssertEqual(provider.name, "Casco Bay Lines")
        XCTAssertEqual(provider.code, "CBL")
        XCTAssertEqual(provider.www, "http://www.cascobaylines.com")
        XCTAssertEqual(provider.routes.count, 1)
    }
}
