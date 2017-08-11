//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class IndexTests: XCTestCase {
    func testCodable() {
        guard let data: Data = try? JSONEncoder().encode(try? JSONDecoder().decode(Index.self, from: data ?? Data())),
            let index: Index = try? JSONDecoder().decode(Index.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(index.name, "Ferry Schedules")
        XCTAssertEqual(index.description, "Islands of Casco Bay")
        XCTAssertEqual(index.timeZone, TimeZone(identifier: "America/New_York"))
        XCTAssertEqual(index.providers.count, 0)
    }
}
