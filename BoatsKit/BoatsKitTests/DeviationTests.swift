import XCTest
@testable import BoatsKit

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
        XCTAssertFalse(Deviation.holiday.isExpired)
    }
}

extension DeviationTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 4080340800.0)).description, "starts 4/20")
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 1524196800.0)).description, "started 4/20")
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 4080340800.0)).description, "ends 4/20")
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 1524196800.0)).description, "ended 4/20")
        XCTAssertEqual(Deviation.holiday.description, "except holiday")
    }
}

extension DeviationTests {
    
    // MARK: Equatable
    func testEqual() {
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 4080340800.0)), Deviation.start(Date(timeIntervalSince1970: 4080340800.0)))
        XCTAssertNotEqual(Deviation.start(Date(timeIntervalSince1970: 4080340800.0)), Deviation.start(Date(timeIntervalSince1970: 1524196800.0)))
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 4080340800.0)), Deviation.end(Date(timeIntervalSince1970: 4080340800.0)))
        XCTAssertNotEqual(Deviation.end(Date(timeIntervalSince1970: 4080340800.0)), Deviation.end(Date(timeIntervalSince1970: 1524196800.0)))
        XCTAssertNotEqual(Deviation.start(Date(timeIntervalSince1970: 4080340800.0)), Deviation.end(Date(timeIntervalSince1970: 4080340800.0)))
        XCTAssertNotEqual(Deviation.end(Date(timeIntervalSince1970: 1555732800.0)), .holiday)
        XCTAssertEqual(Deviation.holiday, .holiday)
    }
}

extension DeviationTests {
    
    // MARK: Codable
    func testDecodeInit() {
        guard let data: Data = data(resource: .bundle, type: "json"),
            let deviations: [Deviation] = try? JSONDecoder.shared.decode([Deviation].self, from: data), deviations.count == 4 else {
            XCTFail()
            return
        }
        XCTAssertEqual(deviations[0], .start(Date(timeIntervalSince1970: 1555732800.0)))
        XCTAssertEqual(deviations[1], .end(Date(timeIntervalSince1970: 1555732800.0)))
        XCTAssertEqual(deviations[2], .only(.friday))
        XCTAssertEqual(deviations[3], .holiday)
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
