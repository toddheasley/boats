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
        guard let _: Data = try? Stylesheet().data() else {
            XCTFail()
            return
        }
    }
}
