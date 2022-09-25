import XCTest
import Boats
@testable import BoatsWeb

class ManifestTests: XCTestCase {
    func testURLInit() {
        XCTAssertNoThrow(try Manifest_Data.write(to: try URL(directory: NSTemporaryDirectory()).appendingPathComponent(Manifest().path)))
        XCTAssertNoThrow(try Manifest(url: try URL(directory: NSTemporaryDirectory())))
    }
    
    func testDataInit() {
        XCTAssertNoThrow(try Manifest(data: Manifest_Data))
        XCTAssertEqual(try? Manifest(data: Manifest_Data).paths, ["favicon.png", "script.js", "index.html", "stylesheet.css"])
    }
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(Manifest().path, "manifest.appcache")
    }
    
    func testData() throws {
        XCTAssertTrue(try Manifest(data: Manifest_Data).data().count > 0)
        XCTAssertEqual(try Manifest().data().count, 15)
    }
}

private let Manifest_Data: Data = """
CACHE MANIFEST
favicon.png
stylesheet.css
script.js
index.html
""".data(using: .utf8)!
