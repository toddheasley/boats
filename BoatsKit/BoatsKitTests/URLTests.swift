import XCTest
@testable import BoatsKit

class URLTests: XCTestCase {
    
}

extension URLTests {
    func testDirectory() {
        XCTAssertEqual(URL(string: "https://toddheasley.github.io/boats/index.json")?.directory, URL(string: "https://toddheasley.github.io/boats/"))
        XCTAssertEqual(URL(string: "https://toddheasley.github.io/boats/")?.directory, URL(string: "https://toddheasley.github.io/boats/"))
        XCTAssertEqual(URL(string: "file:///Users/toddheasley/Boats/index.json")?.directory, URL(string: "file:///Users/toddheasley/Boats/"))
        XCTAssertEqual(URL(string: "file:///Users/toddheasley/Boats/")?.directory, URL(string: "file:///Users/toddheasley/Boats/"))
    }
    
    func testAppending() {
        XCTAssertEqual(URL(string: "https://toddheasley.github.io/boats/data.json")?.appending(uri: URI(resource: "index", type: "json")), URL(string: "https://toddheasley.github.io/boats/index.json"))
        XCTAssertEqual(URL(string: "https://toddheasley.github.io/boats/")?.appending(uri: URI(resource: "index", type: "json")), URL(string: "https://toddheasley.github.io/boats/index.json"))
        XCTAssertEqual(URL(string: "https://toddheasley.github.io/boats/")?.appending(uri: URI(resource: "index")), URL(string: "https://toddheasley.github.io/boats/index"))
        XCTAssertEqual(URL(string: "file:///Users/toddheasley/Boats/data.json")?.appending(uri: URI(resource: "index", type: "json")), URL(string: "file:///Users/toddheasley/Boats/index.json"))
    }
    
    func testAppend() {
        var url: URL? = URL(string: "https://toddheasley.github.io/boats/")
        url?.append(uri: URI(resource: "index", type: "json"))
        XCTAssertEqual(url, URL(string: "https://toddheasley.github.io/boats/index.json"))
        url?.append(uri: URI(resource: "index"))
        XCTAssertEqual(url, URL(string: "https://toddheasley.github.io/boats/index"))
    }
}
