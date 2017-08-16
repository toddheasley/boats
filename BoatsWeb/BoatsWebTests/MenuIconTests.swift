//
//  BoatsWeb
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsWeb

class MenuIconTests: XCTestCase {
    
}

extension MenuIcon {
    func testDataEncoding() {
        guard let _ = try? MenuIcon().data() else {
            XCTFail()
            return
        }
    }
}
