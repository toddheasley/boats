//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class ScheduleTests: XCTestCase {
    func testDecodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Schedule.self, from: data ?? Data())),
            let schedule: Schedule = try? JSON.decoder.decode(Schedule.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(schedule.season.dateInterval, DateInterval(start: Date(timeIntervalSince1970: 1498881600.0), duration: 2592000))
        XCTAssertEqual(schedule.holidays.count, 1)
        XCTAssertEqual(schedule.departures.count, 0)
    }
}
