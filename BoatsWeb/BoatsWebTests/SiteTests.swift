//
//  BoatsWeb
//  © 2017 @toddheasley
//

import XCTest
import BoatsKit
@testable import BoatsWeb

class SiteTests: XCTestCase {
    
}

extension SiteTests {
    func testURLWriting() {
        guard let index: Index = try? Index(data: data(for: .mock, type: "json") ?? Data()) else {
            XCTFail()
            return
        }
        let expect: XCTestExpectation = expectation(description: "")
        
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testURLDeleting() {
        
    }
}
