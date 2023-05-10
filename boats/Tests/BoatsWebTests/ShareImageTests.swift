import XCTest
@testable import BoatsWeb

class ShareImageTests: XCTestCase {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(ShareImage().path, "share-image.png")
    }
    
    func testData() throws {
        XCTAssertEqual(try ShareImage().data().count, 1929, accuracy: 1)
    }
}
