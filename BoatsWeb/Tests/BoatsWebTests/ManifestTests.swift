import XCTest
import BoatsKit
@testable import BoatsWeb

class ManifestTests: XCTestCase {
    
}

extension ManifestTests {
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
    
    func testData() {
        XCTAssertNoThrow(try Manifest(data: Manifest_Data).data())
        XCTAssertNoThrow(try Manifest().data())
    }
}

private let Manifest_Data: Data = """
CACHE MANIFEST
favicon.png
stylesheet.css
script.js
index.html
""".data(using: .utf8)!
