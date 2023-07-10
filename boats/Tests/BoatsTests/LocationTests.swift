import XCTest
import CoreLocation
@testable import Boats

class LocationTests: XCTestCase {
    func testNickname() {
        XCTAssertEqual(Location.portland.nickname, "Portland")
        XCTAssertEqual(Location.peaks.nickname, "Peaks")
        XCTAssertEqual(Location.diamondCove.nickname, "Diamond Cove")
        XCTAssertEqual(Location.chebeague.nickname, "Chebeague")
    }
}

extension LocationTests {
    
    // MARK: Equatable
    func testEqual() {
        XCTAssertNotEqual(Location.peaks, .portland)
        XCTAssertEqual(Location.peaks, .peaks)
    }
}

extension LocationTests {
    
    // MARK: CaseIterable
    func testAllCases() {
        XCTAssertEqual(Location.allCases, [.portland, .peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff, .bailey])
    }
}
