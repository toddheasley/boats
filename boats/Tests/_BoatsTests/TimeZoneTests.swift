import XCTest
@testable import Boats

class TimeZoneTests: XCTestCase {
    
}

extension TimeZoneTests {
    func testShared() {
        XCTAssertEqual(TimeZone.shared.identifier, "America/New_York")
    }
}
