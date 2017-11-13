//
// © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class URITests: XCTestCase {
    func testExpressibleByStringLiteral() {
        XCTAssertEqual(URI(stringLiteral: "\n/ Peaks/-Island.temp##.JSON"), "peaks-island")
        XCTAssertEqual(URI(stringLiteral: "\n/ Peaks/-Island.temp##?.JSON").type, "json")
        XCTAssertEqual(URI(stringLiteral: "\n/ Peaks/-Island.temp##?\r\t"), "peaks-island")
        XCTAssertNil(URI(stringLiteral: "\n/ Peaks/-Island.##?\r\t").type)
    }
    
    func testResource() {
        XCTAssertEqual(URI(resource: "\n/ Peaks/-Island.temp##?\r\t", type: "json"), "peaks-island")
        XCTAssertEqual(URI(resource: "\n/ Peaks/-Island.temp##?\r\t", type: "json").resource, "peaks-island.json")
        XCTAssertEqual(URI(resource: "\n/ Peaks/-Island.temp##?\r\t", type: "json").type, "json")
        XCTAssertEqual(URI(resource: "\n/ Peaks/-Island.temp##?\r\t"), "peaks-island")
        XCTAssertEqual(URI(resource: "\n/ Peaks/-Island.temp##?\r\t").resource, "peaks-island")
        XCTAssertNil(URI(resource: "\n/ Peaks/-Island.temp##?\r\t").type)
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
    func testHashable() {
        XCTAssertNotEqual(URI(stringLiteral: "peaks-island"), URI(stringLiteral: "portland"))
        XCTAssertEqual(URI(stringLiteral: "peaks-island"), URI(stringLiteral: "peaks-island"))
        XCTAssertEqual(URI(stringLiteral: "peaks-island"), "peaks-island")
    }
}
