//
// © 2017 @toddheasley
//

import XCTest
@testable import BoatsWeb

class BookmarkIconTests: XCTestCase {
    
}

extension BookmarkIconTests {
    func testDataEncoding() {
        XCTAssertNotNil(try? BookmarkIcon().data())
    }
}
