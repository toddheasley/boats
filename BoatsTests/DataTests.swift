//
//  DataTests.swift
//  BoatsTests
//
//  (c) 2015 @toddheasley
//

import XCTest
@testable import Boats

class DataTests: XCTestCase {
    func testData() {
        
    }
    
    func testRoute() {
        let JSON = [
            "name": "Name",
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
        let route = Route(JSON: JSON)
        XCTAssertTrue(route != nil)
        XCTAssertEqual(route?.name, "Name")
        XCTAssertEqual(route?.destination.name, "Name")
        XCTAssertEqual(route?.origin.name, "Name")
        XCTAssertEqual(route?.schedules.count, 1)
    }
    
    func testSchedule() {
        let JSON = [
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
                        Day.Monday.rawValue,
                        Day.Wednesday.rawValue
                    ],
                    "time": "07:15",
                    "reverse": false,
                    "cars": true
                ],[
                    "days": [
                        Day.Monday.rawValue,
                        Day.Saturday.rawValue
                    ],
                    "time": "019:45",
                    "reverse": true,
                    "cars": false
                ],
            ]
        ]
        let schedule = Schedule(JSON: JSON)
        XCTAssertEqual(schedule?.season.rawValue, Season.Summer.rawValue)
        XCTAssertEqual(schedule?.dates.start.JSON as? String, "2016-06-21")
        XCTAssertEqual(schedule?.dates.end.JSON as? String, "2016-09-05")
        XCTAssertEqual(schedule?.holidays.count, 1)
        XCTAssertEqual(schedule?.departures.count, 2)
        XCTAssertEqual(schedule?.departures(.Monday, reverse: true).count, 1)
        XCTAssertEqual(schedule?.departures(.Monday).count, 1)
        XCTAssertEqual(schedule?.departures(.Saturday).count, 0)
    }
    
    func testDeparture() {
        let JSON = [
            "days": [
                Day.Monday.rawValue
            ],
            "time": "07:15",
            "reverse": true,
            "cars": true
        ]
        let departure = Departure(JSON: JSON)
        XCTAssertEqual(departure?.days.count, 1)
        XCTAssertEqual(departure?.time.hour, Time(JSON: "07:15")?.hour)
        XCTAssertEqual(departure?.time.minute, Time(JSON: "07:15")?.minute)
        XCTAssertEqual(departure?.reverse, true)
        XCTAssertEqual(departure?.cars, true)
        if let _ = departure, let JSON = departure!.JSON as? [String: AnyObject] {
            XCTAssertEqual((JSON["days"] as? [String])?.count, 1)
            XCTAssertEqual(JSON["time"] as? String, "07:15")
            XCTAssertTrue(JSON["reverse"] as! Bool)
            XCTAssertTrue(JSON["cars"] as! Bool)
        } else {
            XCTFail()
        }
        XCTAssertTrue(Location(JSON: []) == nil)
    }
    
    func testLocation() {
        let JSON = [
            "name": "Name",
            "description": "Description",
            "coordinate": "43.5850105,-70.2315319"
        ]
        let location = Location(JSON: JSON)
        XCTAssertEqual(location?.name, "Name")
        XCTAssertEqual(location?.description, "Description")
        XCTAssertEqual(location?.coordinate.latitude, 43.5850105)
        XCTAssertEqual(location?.coordinate.longitude, -70.2315319)
        XCTAssertEqual(location?.JSON as! [String: String], JSON)
        XCTAssertTrue(Location(JSON: []) == nil)
    }
    
    func testCoordinate() {
        let coordinate = Coordinate(JSON: "43.5850105,-70.2315319")
        XCTAssertEqual(coordinate?.latitude, 43.5850105)
        XCTAssertEqual(coordinate?.longitude, -70.2315319)
        XCTAssertEqual(coordinate?.JSON as? String, "43.5850105,-70.2315319")
        XCTAssertTrue(Coordinate(JSON: "43.5850105") == nil)
        XCTAssertTrue(Coordinate(JSON: "43.5850105,-70.2315319,43.5850105") == nil)
        XCTAssertTrue(Coordinate(JSON: "NaN,NaN") == nil)
    }
    
    func testHoliday() {
        let JSON = [
            "name": "Name",
            "date": "2016-07-04"
        ]
        let holiday = Holiday(JSON: JSON)
        XCTAssertEqual(holiday?.name, "Name")
        XCTAssertEqual(holiday?.date.year, 2016)
        XCTAssertEqual(holiday?.date.month, 07)
        XCTAssertEqual(holiday?.date.day, 04)
        XCTAssertNotNil(holiday?.JSON as? [String: String])
        XCTAssertTrue(Holiday(JSON: "") == nil)
        XCTAssertTrue(Holiday(JSON: []) == nil)
    }
    
    func testDate() {
        var date = Date(JSON: "2016-07-04")
        XCTAssertEqual(date?.year, 2016)
        XCTAssertEqual(date?.month, 7)
        XCTAssertEqual(date?.day, 4)
        XCTAssertEqual(date?.JSON as? String, "2016-07-04")
        date = Date(JSON: "2013-00-00")
        XCTAssertEqual(date?.year, 2015)
        XCTAssertEqual(date?.month, 1)
        XCTAssertEqual(date?.day, 1)
        date = Date(JSON: "3000-13-32")
        XCTAssertEqual(date?.year, 3000)
        XCTAssertEqual(date?.month, 12)
        XCTAssertEqual(date?.day, 31)
        date = Date(JSON: "2020-02-31")
        XCTAssertEqual(date?.day, 29)
        date = Date(JSON: "2021-02-31")
        XCTAssertEqual(date?.day, 28)
        XCTAssertTrue(Date(JSON: "") == nil)
        XCTAssertTrue(Date(JSON: "1234-5-67-89") == nil)
        XCTAssertTrue(Date(JSON: "1234-5") == nil)
    }
    
    func testTime() {
        var time = Time(JSON: "19:45")
        XCTAssertEqual(time?.hour, 19)
        XCTAssertEqual(time?.minute, 45)
        XCTAssertEqual(time?.JSON as? String, "19:45")
        time = Time(JSON: "24:60")
        XCTAssertEqual(time?.hour, 23)
        XCTAssertEqual(time?.minute, 59)
        XCTAssertTrue(Time(JSON: "12") == nil)
        XCTAssertTrue(Date(JSON: "12:34:56") == nil)
    }
}
