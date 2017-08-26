//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class TimeTests: XCTestCase {
    func testComponents() {
        XCTAssertEqual(Time(timeInterval: 0.0).components.hour, 0)
        XCTAssertEqual(Time(timeInterval: 0.0).components.minute, 0)
        XCTAssertEqual(Time(timeInterval: 0.0).components.second, 0)
        XCTAssertEqual(Time(timeInterval: 86399.0).components.hour, 23)
        XCTAssertEqual(Time(timeInterval: 86399.0).components.minute, 59)
        XCTAssertEqual(Time(timeInterval: 86399.0).components.second, 59)
        XCTAssertEqual(Time(timeInterval: 47996.0).components.hour, 13)
        XCTAssertEqual(Time(timeInterval: 47996.0).components.minute, 19)
        XCTAssertEqual(Time(timeInterval: 47996.0).components.second, 56)
    }
    
    func testTimeInterval() {
        XCTAssertEqual(Time(timeInterval: 0.0).timeInterval, 0.0)
        XCTAssertEqual(Time(timeInterval: 72085.1).timeInterval, 72085.0)
        XCTAssertEqual(Time(timeInterval: 86400.0).timeInterval, 0.0)
        XCTAssertEqual(Time(timeInterval: 93066.0).timeInterval, 6666.0)
    }
}

extension TimeTests {
    func testDate() {
        XCTAssertEqual(Time(from: Date(timeIntervalSince1970: 1498881600.0)).timeInterval, 14400.0)
    }
}

extension TimeTests {
    func testCodable() {
        guard let data: Data = try? JSON.encoder.encode([Time(timeInterval: 6666.0)]),
            let time: [Time] = try? JSON.decoder.decode(Array<Time>.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(time[0].timeInterval, 6666.0)
    }
}

extension TimeTests {
    func testComparable() {
        XCTAssertNotEqual(Time(timeInterval: 6666.0), Time(timeInterval: 6667.0))
        XCTAssertEqual(Time(timeInterval: 6666.0), Time(timeInterval: 6666.0))
    }
}
