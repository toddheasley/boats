//
//  BoatsWeb
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit
@testable import BoatsWeb

class ManifestTests: XCTestCase {
    
}

extension ManifestTests {
    func testDataCoding() {
        guard let data: Data = data(for: .mock, type: "appcache"),
            let manifest: Manifest = try? Manifest(data: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(manifest.uris.count, 3)
        XCTAssertNotNil(try manifest.data())
    }
}

extension ManifestTests {
    func testDataReading() {
        guard let url: URL = url(for: .temp, resource: "manifest", type: "appcache"),
            let data: Data = data(for: .mock, type: "appcache"), let _ = try? data.write(to: url) else {
            XCTFail()
            return
        }
        do {
            let _: Manifest = try Manifest(url: url)
        } catch {
            XCTFail()
        }
        let expect: XCTestExpectation = expectation(description: "")
        Manifest.read(from: url) { manifest, error in
            XCTAssertNil(error)
            XCTAssertNotNil(manifest)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testDataWriting() {
        guard let url: URL = url(for: .temp, resource: "manifest", type: "appcache"),
            let manifest: Manifest = try? Manifest(data: data(for: .mock, type: "appcache") ?? Data()) else {
            XCTFail()
            return
        }
        do {
            try manifest.write(to: url)
        } catch {
            XCTFail()
        }
    }
}
