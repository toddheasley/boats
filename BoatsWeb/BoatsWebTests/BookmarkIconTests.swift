import XCTest
@testable import BoatsWeb

class BookmarkIconTests: XCTestCase {
    
}

extension BookmarkIconTests {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(BookmarkIcon().path, "favicon.png")
    }
    
    func testData() {
        XCTAssertNoThrow(try BookmarkIcon().data())
    }
}
