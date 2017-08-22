//
//  BoatsWeb
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsWeb

class ManifestTests: XCTestCase {
    
}

extension ManifestTests {
    func testDataCoding() {
        guard let data: Data = data(for: .mock, type: "appcache"),
            let manifest: Manifest = try? Manifest(data: data),
            let _: Data = try? manifest.data() else {
                XCTFail()
                return
        }
    }
}

extension ManifestTests {
    func testURLReading() {
        guard let url: URL = url(for: .temp, resource: "manifest", type: "appcache"),
            let data: Data = data(for: .mock, type: "appcache"), let _ = try? data.write(to: url) else {
                XCTFail()
                return
        }
        let expect: XCTestExpectation = expectation(description: "")
        Manifest.read(from: url) { manifest, error in
            XCTAssertNil(error)
            XCTAssertEqual(manifest?.uris.count, 3)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testURLWriting() {
        guard let url: URL = Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "appcache"),
            let data: Data = try? Data(contentsOf: url),
            let manifest: Manifest = try? Manifest(data: data) else {
            XCTFail()
            return
        }
        let expect: XCTestExpectation = expectation(description: "")
        manifest.write(to: URL(fileURLWithPath: "\(NSTemporaryDirectory())")) { error in
            XCTAssertNil(error)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
