//
//  ProviderTests.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

class ProviderTests: XCTestCase {
    func testRoute() {
        guard let mockJSON = mockJSON, provider = Provider(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertNotNil(provider.route("CBL_PEAKS"))
        XCTAssertNil(provider.route("#"))
    }
    
    func testJSONEncoding() {
        guard let mockJSON = mockJSON, provider = Provider(JSON: mockJSON), JSON = provider.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual(JSON["name"] as? String, "Casco Bay Lines")
        XCTAssertEqual(JSON["code"] as? String, "CBL")
        XCTAssertEqual(JSON["www"] as? String, "http://www.cascobaylines.com")
        XCTAssertEqual((JSON["routes"] as? [AnyObject])?.count, 1)
    }
    
    func testJSONDecoding() {
        guard let mockJSON = mockJSON, provider = Provider(JSON: mockJSON) else {
            XCTFail()
            return
        }
        XCTAssertEqual(provider.name, "Casco Bay Lines")
        XCTAssertEqual(provider.code, "CBL")
        XCTAssertEqual(provider.www, "http://www.cascobaylines.com")
        XCTAssertEqual(provider.routes.count, 1)
    }
}
