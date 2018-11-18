import XCTest
@testable import BoatsKit

class SeasonTests: XCTestCase {
    
}

extension SeasonTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Season(name: .spring, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1523678400.0), end: Date(timeIntervalSince1970: 1529121599.9))).description, "Spring: Apr 14 – Jun 15, 2018")
        XCTAssertEqual(Season(name: .summer, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))).description, "Summer: Jun 16 – Sep 3, 2018")
        XCTAssertEqual(Season(name: .fall, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1536033600.0), end: Date(timeIntervalSince1970: 1539057599.9))).description, "Fall: Sep 4 – Oct 8, 2018")
        XCTAssertEqual(Season(name: .winter, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1539057600), end: Date(timeIntervalSince1970: 1546664399.9))).description, "Winter: Oct 9, 2018 – Jan 4, 2019")
    }
}
