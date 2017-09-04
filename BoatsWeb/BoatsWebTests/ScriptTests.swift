//
//  BoatsWeb
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsWeb

class ScriptTests: XCTestCase {
    
}

extension ScriptTests {
    func testDataEncoding() {
        guard let _: Data = try? Script().data() else {
            XCTFail()
            return
        }
    }
}

