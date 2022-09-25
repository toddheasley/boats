import XCTest
@testable import BoatsWeb

class ShareImageTests: XCTestCase {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(ShareImage().path, "image.png")
    }
    
    func testData() throws {
        XCTAssertTrue(try ShareImage().data().count > 0)
    }
}
