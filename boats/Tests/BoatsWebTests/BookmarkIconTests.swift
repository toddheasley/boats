import XCTest
@testable import BoatsWeb

class BookmarkIconTests: XCTestCase {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(BookmarkIcon().path, "apple-touch-icon.png")
    }
    
    func testData() throws {
        XCTAssertEqual(try BookmarkIcon().data().count, 304, accuracy: 1)
    }
}
