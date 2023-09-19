import XCTest
@testable import BoatsWeb

class ShareImageTests: XCTestCase {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(ShareImage().path, "share-image.png")
    }
    
    func testData() throws {
        XCTAssertEqual(try ShareImage().data().count, 22878, accuracy: 1)
    }
}
