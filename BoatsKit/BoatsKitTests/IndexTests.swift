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
    func testRead() {
        guard let url: URL = url else {
            XCTFail()
            return
        }
        let expect1: XCTestExpectation = expectation(description: "")
        Index.read(from: url) { index, error in
            XCTAssertNotNil(index)
            XCTAssertNil(error)
            expect1.fulfill()
        }
        let expect2: XCTestExpectation = expectation(description: "")
        Index.read(from: url) { index, error in
            XCTAssertNotNil(index)
            XCTAssertNil(error)
            expect2.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testWrite() {
        guard let index: Index = try? JSON.decoder.decode(Index.self, from: data ?? Data())  else {
            XCTFail()
            return
        }
        let expect: XCTestExpectation = expectation(description: "")
        index.write(to: URL(fileURLWithPath: "\(NSTemporaryDirectory())/IndexTests.json")) { error in
            XCTAssertNil(error)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
