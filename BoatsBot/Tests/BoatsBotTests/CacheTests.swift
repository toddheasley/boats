import XCTest
import BoatsKit
@testable import BoatsBot

class CacheTests: XCTestCase {
    func testIndex() {
        XCTAssertNotNil(Cache(index: Index())?.index)
    }
    
    func testIndexInit() {
        XCTAssertNotNil(Cache(index: Index()))
    }
}
