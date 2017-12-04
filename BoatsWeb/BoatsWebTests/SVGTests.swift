//
// © 2018 @toddheasley
//

import XCTest
@testable import BoatsWeb

class SVGTests: XCTestCase {
    
}

extension SVGTests {
    func testDataEncoding() {
        XCTAssertNotNil(try? SVG.menu.data())
    }
}
