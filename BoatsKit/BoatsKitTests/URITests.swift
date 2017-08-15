//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class URITests: XCTestCase {
    func testExpressibleByStringLiteral() {
        XCTAssertEqual(URI(stringLiteral: "\n/ Peaks/-Island.temp##?\r\t"), "peaks-island")
    }
}

extension URITests {
    func testCodable() {
        guard let data: Data = try? JSON.encoder.encode([URI(stringLiteral: "peaks-island")]),
            let uri: [URI] = try? JSON.decoder.decode(Array<URI>.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(uri[0], "peaks-island")
    }
}

extension URITests {
    func testEquatable() {
        XCTAssertNotEqual(URI(stringLiteral: "peaks-island"), URI(stringLiteral: "portland"))
        XCTAssertEqual(URI(stringLiteral: "peaks-island"), URI(stringLiteral: "peaks-island"))
        XCTAssertEqual(URI(stringLiteral: "peaks-island"), "peaks-island")
    }
}
