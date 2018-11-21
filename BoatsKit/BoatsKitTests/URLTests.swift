import XCTest
@testable import BoatsKit

class URLTests: XCTestCase {
    
}

extension URLTests {
    func testSchedule() {
        XCTAssertEqual(URL.schedule(for: .peaks, season: .spring), URL(string: "https://www.cascobaylines.com/schedules/peaks-island-schedule/spring"))
        XCTAssertEqual(URL.schedule(for: .littleDiamond, season: .summer), URL(string: "https://www.cascobaylines.com/schedules/little-diamond-island-schedule/summer"))
        XCTAssertEqual(URL.schedule(for: .greatDiamond, season: .fall), URL(string: "https://www.cascobaylines.com/schedules/great-diamond-schedule/fall"))
        XCTAssertEqual(URL.schedule(for: .diamondCove, season: .winter), URL(string: "https://www.cascobaylines.com/schedules/diamond-cove-schedule/winter"))
    }
}
