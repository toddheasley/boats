//
//  BoatsWeb
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsWeb

class BookmarkIconTests: XCTestCase {
    
}

extension BookmarkIconTests {
    func testDataEncoding() {
        guard let _: Data = try? BookmarkIcon().data() else {
            XCTFail()
            return
        }
    }
}
