import XCTest
@testable import BoatsWeb

class StylesheetTests: XCTestCase {
    
}

extension StylesheetTests {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(Stylesheet().path, "stylesheet.css")
    }
    
    func testData() {
        XCTAssertNoThrow(try Stylesheet().data())
    }
}
