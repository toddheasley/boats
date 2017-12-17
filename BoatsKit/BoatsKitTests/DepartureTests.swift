import XCTest
@testable import BoatsKit

class DepartureTests: XCTestCase {
    func testCodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Departure.self, from: data(for: .mock, type: "json") ?? Data())),
            let departure: Departure = try? JSON.decoder.decode(Departure.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(departure.direction, .destination)
        XCTAssertEqual(departure.time, Time(timeInterval: 52200.0))
        XCTAssertEqual(departure.days.count, 2)
        XCTAssertEqual(departure.services.count, 3)
    }
}
