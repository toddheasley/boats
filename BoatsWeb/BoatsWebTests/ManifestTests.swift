import XCTest
@testable import BoatsWeb

class ManifestTests: XCTestCase {
    
}

extension ManifestTests {
    func testDataInit() {
        guard let data: Data = data(resource: .bundle, type: "appcache") else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try Manifest(data: data))
        XCTAssertEqual(try? Manifest(data: data).paths, ["favicon.png", "script.js", "index.html", "stylesheet.css"])
    }
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(Manifest().path, "manifest.appcache")
    }
    
    func testData() {
        guard let data: Data = data(resource: .bundle, type: "appcache") else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try Manifest(data: data).data())
        XCTAssertNoThrow(try Manifest().data())
    }
}
