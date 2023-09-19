import XCTest
@testable import Boats

class StringTests: XCTestCase {
    
}

extension StringTests {
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
