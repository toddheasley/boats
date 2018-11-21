import XCTest
@testable import BoatsKit

class IndexTests: XCTestCase {
    func testInit() {
        XCTAssertEqual(Index().name, "Casco Bay Lines")
        XCTAssertEqual(Index().description, "Ferry Schedules")
        XCTAssertEqual(Index().url, URL(string: "https://www.cascobaylines.com"))
        XCTAssertEqual(Index().location, .portland)
        XCTAssertEqual(Index().routes, Route.allCases)
    }
}
