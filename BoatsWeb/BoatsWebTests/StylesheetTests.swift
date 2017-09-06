//
//  BoatsWeb
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsWeb

class StylesheetTests: XCTestCase {
    
}

extension StylesheetTests {
    func testDataEncoding() {
        XCTAssertNotNil(try? Stylesheet().data())
    }
}
