import XCTest
@testable import BoatsWeb

class BookmarkIconTests: XCTestCase {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(BookmarkIcon().path, "apple-touch-icon.png")
    }
    
    func testData() throws {
        XCTAssertTrue(try BookmarkIcon().data().count > 0)
    }
}
