import Testing
@testable import Boats
import Foundation

struct DeviationTests {
    @Test func isExpired() {
        #expect(!Deviation.start(Date(timeIntervalSince1970: 4080340800.0)).isExpired)
        #expect(Deviation.start(Date(timeIntervalSince1970: 1524196800.0)).isExpired)
        #expect(!Deviation.start(Date(timeIntervalSinceNow: 1.0)).isExpired)
        #expect(Deviation.start(Date(timeIntervalSinceNow: -1.0)).isExpired)
        #expect(!Deviation.end(Date()).isExpired)
        #expect(Deviation.end(Date(timeIntervalSinceNow: -86401.0)).isExpired)
        #expect(!Deviation.end(Date(timeIntervalSince1970: 4080340800.0)).isExpired)
        #expect(Deviation.end(Date(timeIntervalSince1970: 1524196800.0)).isExpired)
        #expect(!Deviation.only(Day()).isExpired)
    }
    
    // MARK: CustomAccessibilityStringConvertible
    @Test func accessibilityDescription() {
        #expect(Deviation.start(Date(timeIntervalSince1970: 1593864000.0)).accessibilityDescription == "starts 7/4")
        #expect(Deviation.start(Date(timeIntervalSince1970: 1877860800.0)).accessibilityDescription == "started 7/4")
        #expect(Deviation.end(Date(timeIntervalSince1970: 1877860800.0)).accessibilityDescription == "ends 7/4")
        #expect(Deviation.end(Date(timeIntervalSince1970: 1593864000.0)).accessibilityDescription == "ended 7/4")
        #expect(Deviation.except(.sunday).accessibilityDescription == "except Sunday")
        #expect(Deviation.only(.friday).accessibilityDescription == "Friday only")
    }
    
    @Test func description() {
        #expect(Deviation.start(Date(timeIntervalSince1970: 1593864000.0)).description == "starts 7/4")
        #expect(Deviation.start(Date(timeIntervalSince1970: 1877860800.0)).description == "started 7/4")
        #expect(Deviation.end(Date(timeIntervalSince1970: 1877860800.0)).description == "ends 7/4")
        #expect(Deviation.end(Date(timeIntervalSince1970: 1593864000.0)).description == "ended 7/4")
        #expect(Deviation.except(.sunday).description == "except Sun")
        #expect(Deviation.only(.friday).description == "Fri only")
    }
}

extension DeviationTests {
    
    // MARK: Equatable
    @Test func equal() {
        #expect(Deviation.start(Date(timeIntervalSince1970: 4080340800.0)) != Deviation.end(Date(timeIntervalSince1970: 4080340800.0)))
        #expect(Deviation.start(Date(timeIntervalSince1970: 4080340800.0)) == Deviation.start(Date(timeIntervalSince1970: 4080340800.0)))
        #expect(Deviation.end(Date(timeIntervalSince1970: 4080340800.0)) == Deviation.end(Date(timeIntervalSince1970: 4080340800.0)))
    }
}

extension DeviationTests {
    
    // MARK: Codable
    @Test func decoderInit() throws {
        let deviations: [Deviation] = try #require(try JSONDecoder.shared.decode([Deviation].self, from: JSON_Data))
        #expect(deviations.count == 4)
        #expect(deviations[0] == .start(Date(timeIntervalSince1970: 1555732800.0)))
        #expect(deviations[1] == .end(Date(timeIntervalSince1970: 1555732800.0)))
        #expect(deviations[2] == .except(.sunday))
        #expect(deviations[3] == .only(.friday))
    }
    
    @Test func encode() throws {
        let data: Data = try #require(try JSONEncoder.shared.encode(Deviation.start(Date(timeIntervalSince1970: 1555732800.0))))
        let deviation: Deviation = try #require(try JSONDecoder.shared.decode(Deviation.self, from: data))
        #expect(deviation == .start(Date(timeIntervalSince1970: 1555732800.0)))
    }
}

private let JSON_Data: Data = """
[
    {
        "case": "start",
        "date": 1555732800.0
    },
    {
        "case": "end",
        "date": 1555732800.0
    },
    {
        "case": "except",
        "day": "sunday"
    },
    {
        "case": "only",
        "day": "friday"
    }
]
""".data(using: .utf8)!
