import Testing
@testable import Boats
import Foundation

struct TimeTests {
    @Test func minute() {
        #expect(Time(interval: 86340.0).minute == 59)
        #expect(Time(interval: 53100.0).minute == 45)
        #expect(Time(interval: 21900.0).minute == 5)
        #expect(Time(interval: 0.0).minute == 0)
    }
    
    @Test func hour() {
        #expect(Time(interval: 86340.0).hour == 23)
        #expect(Time(interval: 53100.0).hour == 14)
        #expect(Time(interval: 21900.0).hour == 6)
        #expect(Time(interval: 0.0).hour == 0)
    }
    
    @Test func components() {
        DateFormatter.clockFormat = .twelveHour
        #expect(Time(hour: 6, minute: 15).components(empty: "/") == ["/", "6", ":", "1", "5", "/"])
        #expect(Time(hour: 12, minute: 30).components() == ["1", "2", ":", "3", "0", "."])
        #expect(Time(hour: 13, minute: 0).components() == ["", "1", ":", "0", "0", "."])
        #expect(Time(hour: 23, minute: 45).components() == ["1", "1", ":", "4", "5", "."])
        #expect(Time(hour: 0, minute: 0).components(empty: " ") == ["1", "2", ":", "0", "0", " "])
        DateFormatter.clockFormat = .twentyFourHour
        #expect(Time(hour: 6, minute: 15).components() == ["0", "6", ":", "1", "5", ""])
        #expect(Time(hour: 12, minute: 30).components() == ["1", "2", ":", "3", "0", ""])
        #expect(Time(hour: 13, minute: 0).components(empty: " ") == ["1", "3", ":", "0", "0", " "])
        #expect(Time(hour: 23, minute: 45).components() == ["2", "3", ":", "4", "5", ""])
        #expect(Time(hour: 0, minute: 0).components() == ["0", "0", ":", "0", "0", ""])
        DateFormatter.clockFormat = .system
    }
    
    @Test func intervalInit() {
        #expect(Time(interval: -3600.0).interval == 0.0)
        #expect(Time(interval: 86400.0).interval == 86340.0)
        #expect(Time(interval: 53120.5).interval == 53100.0)
        #expect(Time(interval: 21959.9).interval == 21900.0)
        #expect(Time(interval: 0.0).interval == 0.0)
    }
    
    @Test func hourInit() {
        #expect(Time(hour: 24, minute: 0).interval == 82800.0)
        #expect(Time(hour: 23, minute: 0).interval == 82800.0)
        #expect(Time(hour: 0, minute: 60).interval == 3540.0)
        #expect(Time(hour: 0, minute: 59).interval == 3540.0)
        #expect(Time(hour: 24, minute: 60).interval == 86340.0)
        #expect(Time(hour: 23, minute: 59).interval == 86340.0)
        #expect(Time(hour: 14, minute: 45).interval == 53100.0)
        #expect(Time(hour: 6, minute: 5).interval == 21900.0)
        #expect(Time(hour: -1, minute: 0).interval == 0.0)
        #expect(Time(hour: 0, minute: -1).interval == 0.0)
        #expect(Time(hour: -1, minute: -1).interval == 0.0)
        #expect(Time(hour: 0, minute: 0).interval == 0.0)
    }
    
    @Test func dateInit() {
        #expect(Time(Date(timeIntervalSince1970: 1542230400.0)) == Time(hour: 16, minute: 20))
    }
    
    // MARK: CustomAccessibilityStringConvertible
    @Test func accessibilityDescription() {
        DateFormatter.clockFormat = .twelveHour
        #expect(Time(hour: 6, minute: 15).accessibilityDescription == "6:15AM")
        #expect(Time(hour: 12, minute: 30).accessibilityDescription == "12:30PM")
        #expect(Time(hour: 13, minute: 0).accessibilityDescription == "1:00PM")
        #expect(Time(hour: 23, minute: 45).accessibilityDescription == "11:45PM")
        #expect(Time(hour: 0, minute: 0).accessibilityDescription == "12:00AM")
        DateFormatter.clockFormat = .twentyFourHour
        #expect(Time(hour: 6, minute: 15).accessibilityDescription == "06:15")
        #expect(Time(hour: 12, minute: 30).accessibilityDescription == "12:30")
        #expect(Time(hour: 13, minute: 0).accessibilityDescription == "13:00")
        #expect(Time(hour: 23, minute: 45).accessibilityDescription == "23:45")
        #expect(Time(hour: 0, minute: 0).accessibilityDescription == "00:00")
        DateFormatter.clockFormat = .system
    }
    
    @Test func description() {
        DateFormatter.clockFormat = .twelveHour
        #expect(Time(hour: 6, minute: 15).description == " 6:15 ")
        #expect(Time(hour: 12, minute: 30).description == "12:30.")
        #expect(Time(hour: 13, minute: 0).description == " 1:00.")
        #expect(Time(hour: 23, minute: 45).description == "11:45.")
        #expect(Time(hour: 0, minute: 0).description == "12:00 ")
        DateFormatter.clockFormat = .twentyFourHour
        #expect(Time(hour: 6, minute: 15).description == "06:15")
        #expect(Time(hour: 12, minute: 30).description == "12:30")
        #expect(Time(hour: 13, minute: 0).description == "13:00")
        #expect(Time(hour: 23, minute: 45).description == "23:45")
        #expect(Time(hour: 0, minute: 0).description == "00:00")
        DateFormatter.clockFormat = .system
    }
}

extension TimeTests {
    
    // MARK: Comparable
    @Test func equal() {
        #expect(Time(hour: 10, minute: 45) != Time(hour: 10, minute: 44))
        #expect(Time(hour: 10, minute: 45) != Time(hour: 10, minute: 46))
        #expect(Time(hour: 10, minute: 45) == Time(hour: 10, minute: 45))
    }
    
    @Test func lessThan() {
        #expect(Time(hour: 10, minute: 44) < Time(hour: 10, minute: 45))
    }
}

extension TimeTests {
    
    // MARK: Codable
    @Test func decoderInit() throws {
        let times: [Time] = try #require(try JSONDecoder.shared.decode([Time].self, from: JSON_Data))
        #expect(times.count == 2)
        #expect(times.first == Time(hour: 23, minute: 59))
        #expect(times.last == Time(hour: 0, minute: 0))
    }
    
    @Test func encode() throws {
        let data: Data = try #require(try JSONEncoder.shared.encode(Time(hour: 12, minute: 30)))
        let time: Time = try #require(try JSONDecoder.shared.decode(Time.self, from: data))
        #expect(time == Time(hour: 12, minute: 30))
    }
}

extension TimeTests {
    
    // MARK: HTMLConvertible
    @Test func htmlInit() throws {
        #expect(try Time(from: "\nPM9:41") == Time(hour: 21, minute: 41))
        #expect(try Time(from: "AM9:41 ") == Time(hour: 9, minute: 41))
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
