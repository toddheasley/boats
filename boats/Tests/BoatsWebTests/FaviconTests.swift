import XCTest
@testable import BoatsWeb

class FaviconTests: XCTestCase {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(Favicon().path, "favicon.ico")
    }
    
    func testData() throws {
        XCTAssertEqual(try Favicon().data().count, 135, accuracy: 1)
    }
}
