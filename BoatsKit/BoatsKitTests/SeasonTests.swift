//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class SeasonTests: XCTestCase {
    func testDateInterval() {
        let dateInterval: DateInterval = DateInterval(start: Date(), end: Date())
        XCTAssertEqual(Season.spring(dateInterval).dateInterval, dateInterval)
        XCTAssertEqual(Season.summer(dateInterval).dateInterval, dateInterval)
        XCTAssertEqual(Season.fall(dateInterval).dateInterval, dateInterval)
        XCTAssertEqual(Season.winter(dateInterval).dateInterval, dateInterval)
        XCTAssertNil(Season.evergreen.dateInterval)
    }
}

extension SeasonTests {
    func testCodable() {
        guard let data1: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Season.self, from: data ?? Data())),
            let season1: Season = try? JSON.decoder.decode(Season.self, from: data1) else {
            XCTFail()
            return
        }
        switch season1 {
        case .winter:
            XCTAssertEqual(season1.dateInterval, DateInterval(start: Date(timeIntervalSince1970: 1514692800.0), duration: 2592000))
        default:
            XCTFail()
        }
        guard let data2: Data = try? JSON.encoder.encode(Season.evergreen),
            let season2: Season = try? JSON.decoder.decode(Season.self, from: data2) else {
            XCTFail()
            return
        }
        switch season2 {
        case .evergreen:
            XCTAssertNil(season2.dateInterval)
        default:
            XCTFail()
        }
    }
}
