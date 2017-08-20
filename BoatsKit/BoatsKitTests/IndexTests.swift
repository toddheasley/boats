//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class IndexTests: XCTestCase {
    func testCodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Index.self, from: data ?? Data())),
            let index: Index = try? JSON.decoder.decode(Index.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(index.name, "Ferry Schedules")
        XCTAssertEqual(index.uri, "index")
        XCTAssertEqual(index.description, "Islands of Casco Bay")
        XCTAssertEqual(index.localization.timeZone, TimeZone(identifier: "America/New_York"))
        XCTAssertEqual(index.providers.count, 0)
    }
}

extension IndexTests {
    func testDataCoding() {
        guard let index: Index = try? Index(data: data ?? Data()),
            let _: Data = try? index.data() else {
            XCTFail()
            return
        }
    }
}

extension IndexTests {
    func testURLReading() {
        let url: URL = URL(fileURLWithPath: "\(NSTemporaryDirectory())")
        guard let data: Data = data,
            let _ = try? data.write(to: url.appendingPathComponent("index.json")) else {
            XCTFail()
            return
        }
        let expect: XCTestExpectation = expectation(description: "")
        Index.read(from: url) { index, error in
            XCTAssertNil(error)
            XCTAssertNotNil(index)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testURLWriting() {
        guard let index: Index = try? JSON.decoder.decode(Index.self, from: data ?? Data())  else {
            XCTFail()
            return
        }
        let expect: XCTestExpectation = expectation(description: "")
        index.write(to: URL(fileURLWithPath: "\(NSTemporaryDirectory())")) { error in
            XCTAssertNil(error)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
