//
// © 2017 @toddheasley
//

import XCTest
@testable import BoatsWeb

class ScriptTests: XCTestCase {
    
}

extension ScriptTests {
    func testDataEncoding() {
        XCTAssertNotNil(try? Script().data())
    }
}

