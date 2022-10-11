import XCTest
@testable import BoatsWeb

class StylesheetTests: XCTestCase {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(Stylesheet().path, "stylesheet.css")
    }
    
    func testData() throws {
        XCTAssertEqual(try Stylesheet().data().count, 775, accuracy: 1)
    }
}
