//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class HolidayTests: XCTestCase {
    func testCodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Holiday.self, from: data(for: .mock, type: "json") ?? Data())),
            let holiday: Holiday = try? JSON.decoder.decode(Holiday.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(holiday.name, "Independence Day")
        XCTAssertEqual(holiday.date, Date(timeIntervalSince1970: 1499140800.0))
    }
}
