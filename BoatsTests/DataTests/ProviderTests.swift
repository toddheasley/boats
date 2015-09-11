//
//  ProviderTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest

class ProviderTests: XCTestCase {
    let JSON: [String: AnyObject] = [
        "name": "Name",
        "code": "#",
        "www": "https://example.com",
        "routes": [
            [
                "name": "Name",
                "code": "#",
                "destination": [
                    "name": "Name",
                    "description": "Description",
                    "coordinate": "43.5850105,-70.2315319"
                ],
                "origin": [
                    "name": "Name",
                    "description": "Description",
                    "coordinate": "43.5850105,-70.2315319"
                ],
                "schedules": [
                    [
                        "season": Season.Summer.rawValue,
                        "dates": "2016-06-21,2016-09-05",
                        "holidays": [],
                        "departures": []
                    ]
                ]
            ]
        ]
    ]
    
    func testRoute() {

            //XCTAssertNotNil(data.route(data.routes[0].code))
            //XCTAssertNil(data.route("#"))
    }
    
    func testJSONDecoding() {
        XCTAssertEqual(Provider(JSON: JSON)?.name, "Name")
        XCTAssertEqual(Provider(JSON: JSON)?.code, "#")
        XCTAssertEqual(Provider(JSON: JSON)?.www, "https://example.com")
        XCTAssertEqual(Provider(JSON: JSON)?.routes.count, 1)
        XCTAssertTrue(Location(JSON: []) == nil)
    }
    
    func testJSONEncoding() {
        guard let _ = Provider(JSON: JSON), _ = Provider(JSON: JSON)?.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual((Provider(JSON: JSON)!.JSON as! [String: AnyObject])["name"] as? String, "Name")
        XCTAssertEqual((Provider(JSON: JSON)!.JSON as! [String: AnyObject])["code"] as? String, "#")
        XCTAssertNotNil(((Provider(JSON: JSON)?.JSON as! [String: AnyObject])["routes"] as? [AnyObject]))
        XCTAssertEqual((Provider(JSON: JSON)!.JSON as! [String: AnyObject])["www"] as? String, "https://example.com")
    }
}
