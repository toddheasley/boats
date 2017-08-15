//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class URLTests: XCTestCase {
    
}

extension URLTests {
    func testURI() {
        XCTAssertEqual(URL(base: URL(string: "file:///Users/Documents/")!, uri: "index.json").absoluteString, "file:///Users/Documents/index")
        XCTAssertEqual(URL(base: URL(string: "file:///Users/Documents/Boats.app")!, uri: "index", type: "json").absoluteString, "file:///Users/Documents/index.json")
        XCTAssertEqual(URL(base: URL(string: "https://boats.example")!, uri: "index.json", type: "json").absoluteString, "https://boats.example/index.json")
    }
}
