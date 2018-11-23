import XCTest
@testable import BoatsKit

class StringTests: XCTestCase {
    
}

extension SeasonTests {
    func testCapitalized() {
        XCTAssertEqual("ferry schedules for the islands of Casco Bay".capitalized(case: .sentence), "Ferry schedules for the islands of Casco Bay")
        XCTAssertEqual("chebeague island schedule".capitalized(case: .title), "Chebeague Island Schedule")
    }
    
    func testFind() {
        XCTAssertEqual("<p style=\"text-align: center;\"><span style=\"font-size: large;\"><strong>Currently Displaying:</strong> Winter Schedule </span><br />".find("<span[^>]*>(.*?)</span>").first, "<strong>Currently Displaying:</strong> Winter Schedule ")
    }
    
    func testStripHTML() {
        XCTAssertEqual("<p style=\"text-align: center;\"><span style=\"font-size: large;\"><strong>Currently Displaying:</strong> Winter Schedule </span><br />".stripHTML(), "Currently Displaying: Winter Schedule ")
    }
    
    func testTrim() {
        XCTAssertEqual(" \n".trim(), "")
        XCTAssertEqual(" Portland's Iconic Ferry\nServicing the Islands of Casco Bay\n".trim(), "Portland's Iconic Ferry\nServicing the Islands of Casco Bay")
        XCTAssertEqual("".trim(), "")
    }
}
