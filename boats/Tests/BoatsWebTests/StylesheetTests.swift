import XCTest
@testable import BoatsWeb

class StylesheetTests: XCTestCase {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(Stylesheet().path, "stylesheet.css")
    }
    
    func testData() throws {
        XCTAssertTrue(try Stylesheet().data().count > 0)
    }
}
