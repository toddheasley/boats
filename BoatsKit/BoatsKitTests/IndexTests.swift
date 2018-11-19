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
    
    func testRouteScheduleURL() {
        XCTAssertEqual(Index().scheduleURL(for: .peaks, season: .spring), URL(string: "https://www.cascobaylines.com/schedules/peaks-island-schedule/spring"))
        XCTAssertEqual(Index().scheduleURL(for: .littleDiamond, season: .summer), URL(string: "https://www.cascobaylines.com/schedules/little-diamond-island-schedule/summer"))
        XCTAssertEqual(Index().scheduleURL(for: .greatDiamond, season: .fall), URL(string: "https://www.cascobaylines.com/schedules/great-diamond-schedule/fall"))
        XCTAssertEqual(Index().scheduleURL(for: .diamondCove, season: .winter), URL(string: "https://www.cascobaylines.com/schedules/diamond-cove-schedule/winter"))
    }
}
