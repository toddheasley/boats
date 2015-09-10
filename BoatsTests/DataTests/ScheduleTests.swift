//
//  ScheduleTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest

class ScheduleTests: XCTestCase {
    let JSON: [String: AnyObject] = [
        "season": Season.Summer.rawValue,
        "dates": "2016-06-21,2016-09-05",
        "holidays": [
            [
                "name": "Name",
                "date": "2016-07-04"
            ]
        ],
        "departures": [
            [
                "days": [
                    Day.Everyday.rawValue
                ],
                "time": "07:15",
                "direction": Direction.Destination.rawValue,
                "cars": true
            ],[
                "days": [
                    Day.Monday.rawValue,
                    Day.Saturday.rawValue
                ],
                "time": "019:45",
                "direction": Direction.Origin.rawValue,
                "cars": false
            ]
        ]
    ]
    
    func testJSONDecoding() {
        XCTAssertEqual(Schedule(JSON: JSON)?.season.rawValue, Season.Summer.rawValue)
        XCTAssertEqual(Schedule(JSON: JSON)?.dates.start.JSON as? String, "2016-06-21")
        XCTAssertEqual(Schedule(JSON: JSON)?.dates.end.JSON as? String, "2016-09-05")
        XCTAssertEqual(Schedule(JSON: JSON)?.holidays.count, 1)
        XCTAssertEqual(Schedule(JSON: JSON)?.departures.count, 2)
    }
    
    func testJSONEncoding() {
        guard let _ = Schedule(JSON: JSON), _ = Schedule(JSON: JSON)?.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual((Schedule(JSON: JSON)!.JSON as! [String: AnyObject])["season"] as? String, "Summer")
        XCTAssertEqual((Schedule(JSON: JSON)!.JSON as! [String: AnyObject])["dates"] as? String, "2016-06-21,2016-09-05")
        XCTAssertEqual(((Schedule(JSON: JSON)!.JSON as! [String: AnyObject])["holidays"] as! [AnyObject]).count, 1)
        XCTAssertEqual(((Schedule(JSON: JSON)!.JSON as! [String: AnyObject])["departures"] as! [AnyObject]).count, 2)
    }
    
    func testDepartures() {
        guard let _ = Schedule(JSON: JSON), _ = Schedule(JSON: JSON)?.JSON as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual(Schedule(JSON: JSON)?.departures(.Monday).count, 2)
        XCTAssertEqual(Schedule(JSON: JSON)?.departures(.Monday, direction: .Destination).count, 1)
        XCTAssertEqual(Schedule(JSON: JSON)?.departures(.Wednesday, direction: .Origin).count, 0)
        XCTAssertEqual(Schedule(JSON: JSON)?.departures(.Monday, direction: .Origin).count, 1)
    }
}
