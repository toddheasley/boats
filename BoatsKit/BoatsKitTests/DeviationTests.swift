import XCTest
@testable import BoatsKit

class DeviationTests: XCTestCase {
    
}

extension DeviationTests {
    func testDateDescription() {
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 1555732800.0)).description(relativeTo: Date(timeIntervalSince1970: 1555732799.0)), "starts 4/20")
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 1555732800.0)).description(relativeTo: Date(timeIntervalSince1970: 1555732800.0)), "started 4/20")
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 1555732800.0)).description(), "starts 4/20")
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 1555732800.0)).description(relativeTo: Date(timeIntervalSince1970: 1555819199.0)), "ends 4/20")
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 1555732800.0)).description(relativeTo: Date(timeIntervalSince1970: 1555819200.0)), "ended 4/20")
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 1555732800.0)).description(), "ends 4/20")
        XCTAssertEqual(Deviation.holiday.description(relativeTo: Date()), "except holiday")
        XCTAssertEqual(Deviation.holiday.description(), "except holiday")
    }
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 1555732800.0)).description, "starts 4/20")
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 1555732800.0)).description, "ends 4/20")
        XCTAssertEqual(Deviation.holiday.description, "except holiday")
    }
}

extension DeviationTests {
    
    // MARK: Equatable
    func testEqual() {
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 1555732800.0)), .start(Date(timeIntervalSince1970: 1555732800.0)))
        XCTAssertEqual(Deviation.start(Date(timeIntervalSince1970: 1555732800.0)), .start(Date(timeIntervalSince1970: 1524196800.0)))
        XCTAssertNotEqual(Deviation.start(Date(timeIntervalSince1970: 1555732800.0)), .start(Date(timeIntervalSince1970: 1546318800.0)))
        XCTAssertNotEqual(Deviation.start(Date(timeIntervalSince1970: 1555732800.0)), .end(Date(timeIntervalSince1970: 1555732800.0)))
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 1555732800.0)), .end(Date(timeIntervalSince1970: 1555732800.0)))
        XCTAssertEqual(Deviation.end(Date(timeIntervalSince1970: 1555732800.0)), .end(Date(timeIntervalSince1970: 1524196800.0)))
        XCTAssertNotEqual(Deviation.end(Date(timeIntervalSince1970: 1555732800.0)), .end(Date(timeIntervalSince1970: 1546318800.0)))
        XCTAssertNotEqual(Deviation.end(Date(timeIntervalSince1970: 1555732800.0)), .holiday)
        XCTAssertEqual(Deviation.holiday, .holiday)
    }
}

extension DeviationTests {
    
    // MARK: Codable
    func testDecodeInit() {
        guard let data: Data = data(resource: .bundle, type: "json"),
            let deviations: [Deviation] = try? JSONDecoder.shared.decode([Deviation].self, from: data), deviations.count == 3 else {
            XCTFail()
            return
        }
        XCTAssertEqual(deviations[0], .start(Date(timeIntervalSince1970: 1555732800.0)))
        XCTAssertEqual(deviations[1], .end(Date(timeIntervalSince1970: 1555732800.0)))
        XCTAssertEqual(deviations[2], .holiday)
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
