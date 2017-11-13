//
// © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class IndexTests: XCTestCase {
    func testCodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Index.self, from: data(for: .mock, type: "json") ?? Data())),
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
        guard let index: Index = try? Index(data: data(for: .mock, type: "json") ?? Data()),
            let _: Data = try? index.data() else {
            XCTFail()
            return
        }
    }
}

extension IndexTests {
    func testDataReading() {
        guard let url: URL = url(for: .temp, resource: "index", type: "json"),
            let data: Data = data(for: .mock, type: "json"), let _ = try? data.write(to: url) else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try Index(url: url))
        let expect: XCTestExpectation = expectation(description: "")
        Index.read(from: url) { index, error in
            XCTAssertNil(error)
            XCTAssertNotNil(index)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testDataWriting() {
        guard let index: Index = try? JSON.decoder.decode(Index.self, from: data(for: .mock, type: "json") ?? Data()),
            let url: URL = url(for: .temp, type: "json") else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try index.write(to: url))
    }
}
