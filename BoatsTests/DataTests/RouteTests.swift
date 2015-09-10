//
//  RouteTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest

class RouteTests: XCTestCase {
    let JSON: [String: AnyObject] = [
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
    
    func testSchedule() {
        guard let _ = Route(JSON: JSON) else {
            XCTFail()
            return
        }
        XCTAssertNotNil(Route(JSON: JSON)!.schedule(Date(JSON: "2016-08-01")!))
        XCTAssertTrue(Route(JSON: JSON)!.schedule(Date(JSON: "2015-12-31")!) == nil)
        XCTAssertTrue(Route(JSON: JSON)!.schedule(Date(JSON: "2016-10-15")!) == nil)
    }
    
    func testJSONDecoding() {
        XCTAssertEqual(Route(JSON: JSON)?.name, "Name")
        XCTAssertEqual(Route(JSON: JSON)?.code, "#")
        XCTAssertEqual(Route(JSON: JSON)?.destination.name, "Name")
        XCTAssertEqual(Route(JSON: JSON)?.origin.name, "Name")
        XCTAssertEqual(Route(JSON: JSON)?.schedules.count, 1)
    }
    
    func testJSONEncoding() {
        guard let _ = Route(JSON: JSON), _ = Route(JSON: JSON)?.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual((Route(JSON: JSON)!.JSON as! [String: AnyObject])["name"] as? String, "Name")
        XCTAssertEqual((Route(JSON: JSON)!.JSON as! [String: AnyObject])["code"] as? String, "#")
        XCTAssertNotNil((Route(JSON: JSON)!.JSON as! [String: AnyObject])["destination"] as? [String: AnyObject])
        XCTAssertNotNil((Route(JSON: JSON)!.JSON as! [String: AnyObject])["origin"] as? [String: AnyObject])
        XCTAssertEqual(((Route(JSON: JSON)!.JSON as! [String: AnyObject])["schedules"] as! [AnyObject]).count, 1)
    }
}
