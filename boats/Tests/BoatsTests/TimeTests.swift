import XCTest
@testable import Boats

class TimeTests: XCTestCase {
    func testMinute() {
        XCTAssertEqual(Time(interval: 86340.0).minute, 59)
        XCTAssertEqual(Time(interval: 53100.0).minute, 45)
        XCTAssertEqual(Time(interval: 21900.0).minute, 5)
        XCTAssertEqual(Time(interval: 0.0).minute, 0)
    }
    
    func testHour() {
        XCTAssertEqual(Time(interval: 86340.0).hour, 23)
        XCTAssertEqual(Time(interval: 53100.0).hour, 14)
        XCTAssertEqual(Time(interval: 21900.0).hour, 6)
        XCTAssertEqual(Time(interval: 0.0).hour, 0)
    }
    
    func testComponents() {
        DateFormatter.clockFormat = .twelveHour
        XCTAssertEqual(Time(hour: 6, minute: 15).components(empty: "/"), ["/", "6", ":", "1", "5", "/"])
        XCTAssertEqual(Time(hour: 12, minute: 30).components(), ["1", "2", ":", "3", "0", "."])
        XCTAssertEqual(Time(hour: 13, minute: 0).components(), ["", "1", ":", "0", "0", "."])
        XCTAssertEqual(Time(hour: 23, minute: 45).components(), ["1", "1", ":", "4", "5", "."])
        XCTAssertEqual(Time(hour: 0, minute: 0).components(empty: " "), ["1", "2", ":", "0", "0", " "])
        DateFormatter.clockFormat = .twentyFourHour
        XCTAssertEqual(Time(hour: 6, minute: 15).components(), ["0", "6", ":", "1", "5", ""])
        XCTAssertEqual(Time(hour: 12, minute: 30).components(), ["1", "2", ":", "3", "0", ""])
        XCTAssertEqual(Time(hour: 13, minute: 0).components(empty: " "), ["1", "3", ":", "0", "0", " "])
        XCTAssertEqual(Time(hour: 23, minute: 45).components(), ["2", "3", ":", "4", "5", ""])
        XCTAssertEqual(Time(hour: 0, minute: 0).components(), ["0", "0", ":", "0", "0", ""])
        DateFormatter.clockFormat = .system
    }
    
    func testIntervalInit() {
        XCTAssertEqual(Time(interval: -3600.0).interval, 0.0)
        XCTAssertEqual(Time(interval: 86400.0).interval, 86340.0)
        XCTAssertEqual(Time(interval: 53120.5).interval, 53100.0)
        XCTAssertEqual(Time(interval: 21959.9).interval, 21900.0)
        XCTAssertEqual(Time(interval: 0.0).interval, 0.0)
    }
    
    func testHourInit() {
        XCTAssertEqual(Time(hour: 24, minute: 0).interval, 82800.0)
        XCTAssertEqual(Time(hour: 23, minute: 0).interval, 82800.0)
        XCTAssertEqual(Time(hour: 0, minute: 60).interval, 3540.0)
        XCTAssertEqual(Time(hour: 0, minute: 59).interval, 3540.0)
        XCTAssertEqual(Time(hour: 24, minute: 60).interval, 86340.0)
        XCTAssertEqual(Time(hour: 23, minute: 59).interval, 86340.0)
        XCTAssertEqual(Time(hour: 14, minute: 45).interval, 53100.0)
        XCTAssertEqual(Time(hour: 6, minute: 5).interval, 21900.0)
        XCTAssertEqual(Time(hour: -1, minute: 0).interval, 0.0)
        XCTAssertEqual(Time(hour: 0, minute: -1).interval, 0.0)
        XCTAssertEqual(Time(hour: -1, minute: -1).interval, 0.0)
        XCTAssertEqual(Time(hour: 0, minute: 0).interval, 0.0)
    }
    
    func testDateInit() {
        XCTAssertEqual(Time(Date(timeIntervalSince1970: 1542230400.0)), Time(hour: 16, minute: 20))
    }
    
    // MARK: CustomAccessibilityStringConvertible
    func testAccessibilityDescription() {
        DateFormatter.clockFormat = .twelveHour
        XCTAssertEqual(Time(hour: 6, minute: 15).accessibilityDescription, "6:15AM")
        XCTAssertEqual(Time(hour: 12, minute: 30).accessibilityDescription, "12:30PM")
        XCTAssertEqual(Time(hour: 13, minute: 0).accessibilityDescription, "1:00PM")
        XCTAssertEqual(Time(hour: 23, minute: 45).accessibilityDescription, "11:45PM")
        XCTAssertEqual(Time(hour: 0, minute: 0).accessibilityDescription, "12:00AM")
        DateFormatter.clockFormat = .twentyFourHour
        XCTAssertEqual(Time(hour: 6, minute: 15).accessibilityDescription, "06:15")
        XCTAssertEqual(Time(hour: 12, minute: 30).accessibilityDescription, "12:30")
        XCTAssertEqual(Time(hour: 13, minute: 0).accessibilityDescription, "13:00")
        XCTAssertEqual(Time(hour: 23, minute: 45).accessibilityDescription, "23:45")
        XCTAssertEqual(Time(hour: 0, minute: 0).accessibilityDescription, "00:00")
        DateFormatter.clockFormat = .system
    }
    
    func testDescription() {
        DateFormatter.clockFormat = .twelveHour
        XCTAssertEqual(Time(hour: 6, minute: 15).description, " 6:15 ")
        XCTAssertEqual(Time(hour: 12, minute: 30).description, "12:30.")
        XCTAssertEqual(Time(hour: 13, minute: 0).description, " 1:00.")
        XCTAssertEqual(Time(hour: 23, minute: 45).description, "11:45.")
        XCTAssertEqual(Time(hour: 0, minute: 0).description, "12:00 ")
        DateFormatter.clockFormat = .twentyFourHour
        XCTAssertEqual(Time(hour: 6, minute: 15).description, "06:15")
        XCTAssertEqual(Time(hour: 12, minute: 30).description, "12:30")
        XCTAssertEqual(Time(hour: 13, minute: 0).description, "13:00")
        XCTAssertEqual(Time(hour: 23, minute: 45).description, "23:45")
        XCTAssertEqual(Time(hour: 0, minute: 0).description, "00:00")
        DateFormatter.clockFormat = .system
    }
}

extension TimeTests {
    
    // MARK: Comparable
    func testEqual() {
        XCTAssertNotEqual(Time(hour: 10, minute: 45), Time(hour: 10, minute: 44))
        XCTAssertNotEqual(Time(hour: 10, minute: 45), Time(hour: 10, minute: 46))
        XCTAssertEqual(Time(hour: 10, minute: 45), Time(hour: 10, minute: 45))
    }
    
    func testLessThan() {
        XCTAssertLessThan(Time(hour: 10, minute: 44), Time(hour: 10, minute: 45))
    }
}

extension TimeTests {
    
    // MARK: Codable
    func testDecoderInit() {
        guard let times: [Time] = try? JSONDecoder.shared.decode([Time].self, from: JSON_Data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(times.count, 2)
        XCTAssertEqual(times.first, Time(hour: 23, minute: 59))
        XCTAssertEqual(times.last, Time(hour: 0, minute: 0))
    }
    
    func testEncode() {
        guard let data: Data = try? JSONEncoder.shared.encode(Time(hour: 12, minute: 30)),
            let time: Time = try? JSONDecoder.shared.decode(Time.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(time, Time(hour: 12, minute: 30))
    }
}

extension TimeTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() {
        XCTAssertEqual(try? Time(from: "\nPM9:41"), Time(hour: 21, minute: 41))
        XCTAssertEqual(try? Time(from: "AM9:41 "), Time(hour: 9, minute: 41))
    }
}

private let JSON_Data: Data = """
[
    {
        "hour": 23,
        "minute": 59
    },
    {
        "hour": 0,
        "minute": 0
    }
]
""".data(using: .utf8)!
