import XCTest
@testable import Boats

class DeviationTests: XCTestCase {
    func testIsExpired() {
        XCTAssertFalse(Deviation.start(Date(timeIntervalSince1970: 4080340800.0)).isExpired)
        XCTAssertTrue(Deviation.start(Date(timeIntervalSince1970: 1524196800.0)).isExpired)
        XCTAssertFalse(Deviation.start(Date(timeIntervalSinceNow: 1.0)).isExpired)
        XCTAssertTrue(Deviation.start(Date(timeIntervalSinceNow: -1.0)).isExpired)
        XCTAssertFalse(Deviation.end(Date()).isExpired)
        XCTAssertTrue(Deviation.end(Date(timeIntervalSinceNow: -86401.0)).isExpired)
        XCTAssertFalse(Deviation.end(Date(timeIntervalSince1970: 4080340800.0)).isExpired)
        XCTAssertTrue(Deviation.end(Date(timeIntervalSince1970: 1524196800.0)).isExpired)
        XCTAssertFalse(Deviation.only(Day()).isExpired)
    }
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 1593864000.0)).description, "starts 7/4")
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 1877860800.0)).description, "started 7/4")
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 1877860800.0)).description, "ends 7/4")
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 1593864000.0)).description, "ended 7/4")
        XCTAssertEqual(Deviation.except(.sunday).description, "except Sun")
        XCTAssertEqual(Deviation.only(.friday).description, "Fri only")
    }
}

extension DeviationTests {
    
    // MARK: Equatable
    func testEqual() {
        XCTAssertNotEqual(Deviation.start(Date(timeIntervalSince1970: 4080340800.0)), Deviation.end(Date(timeIntervalSince1970: 4080340800.0)))
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 4080340800.0)), Deviation.start(Date(timeIntervalSince1970: 4080340800.0)))
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 4080340800.0)), Deviation.end(Date(timeIntervalSince1970: 4080340800.0)))
    }
}

extension DeviationTests {
    
    // MARK: Codable
    func testDecoderInit() {
        guard let deviations: [Deviation] = try? JSONDecoder.shared.decode([Deviation].self, from: JSON_Data), deviations.count == 4 else {
            XCTFail()
            return
        }
        XCTAssertEqual(deviations[0], .start(Date(timeIntervalSince1970: 1555732800.0)))
        XCTAssertEqual(deviations[1], .end(Date(timeIntervalSince1970: 1555732800.0)))
        XCTAssertEqual(deviations[2], .except(.sunday))
        XCTAssertEqual(deviations[3], .only(.friday))
    }
    
    func testEncode() {
        guard let data: Data = try? JSONEncoder.shared.encode(Deviation.start(Date(timeIntervalSince1970: 1555732800.0))),
            let deviation: Deviation = try? JSONDecoder.shared.decode(Deviation.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(deviation, .start(Date(timeIntervalSince1970: 1555732800.0)))
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
