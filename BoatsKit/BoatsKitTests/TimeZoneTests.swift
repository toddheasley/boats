import XCTest
@testable import BoatsKit

class TimeZoneTests: XCTestCase {
    
}

extension TimeZoneTests {
    func testShared() {
        XCTAssertEqual(TimeZone.shared.identifier, "America/New_York")
    }
}
