//
//  BoatsWeb
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsWeb

class HTMLTests: XCTestCase {
    
}

extension HTMLTests {
    func testDataEncoding() {
        guard let _ = try? HTML(stringLiteral: "").data() else {
            XCTFail()
            return
        }
    }
}

