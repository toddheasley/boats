//
//  DepartureTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest

class DepartureTests: XCTestCase {
    let JSON: [String: AnyObject] = [
        "days": [
            Day.Monday.rawValue
        ],
        "time": "07:15",
        "direction": Direction.Destination.rawValue,
        "cars": true
    ]
    
    func testJSONDecoding() {
        XCTAssertEqual(Departure(JSON: JSON)?.days.count, 1)
        XCTAssertEqual(Departure(JSON: JSON)?.time.hour, Time(JSON: "07:15")?.hour)
        XCTAssertEqual(Departure(JSON: JSON)?.time.minute, Time(JSON: "07:15")?.minute)
        XCTAssertEqual(Departure(JSON: JSON)?.direction, Direction.Destination)
        XCTAssertEqual(Departure(JSON: JSON)?.cars, true)
        XCTAssertTrue(Location(JSON: []) == nil)
    }
    
    func testJSONEncoding() {
        guard let _ = Departure(JSON: JSON), _ = Departure(JSON: JSON)?.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual((Departure(JSON: JSON)!.JSON as! [String: AnyObject])["days"] as! [String], ["Monday"])
        XCTAssertEqual((Departure(JSON: JSON)!.JSON as! [String: AnyObject])["time"] as? String, "07:15")
        XCTAssertEqual((Departure(JSON: JSON)!.JSON as! [String: AnyObject])["direction"] as? String, Direction.Destination.rawValue)
        XCTAssertEqual((Departure(JSON: JSON)!.JSON as! [String: AnyObject])["cars"] as? Bool, true)
    }
}
