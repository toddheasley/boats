//
//  BoatsWeb
//  © 2017 @toddheasley
//

import XCTest
import BoatsKit
@testable import BoatsWeb

class HTMLDocumentTests: XCTestCase {
    
}

extension HTMLDocumentTests {
    func testDataEncoding() {
        guard let _ = try? HTMLDocument(uri: "").data() else {
            XCTFail()
            return
        }
    }
}
