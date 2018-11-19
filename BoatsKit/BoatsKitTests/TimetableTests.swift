import XCTest
@testable import BoatsKit

class TimetableTests: XCTestCase {
    
}

extension TimetableTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Timetable(trips: [], days: [.monday, .tuesday, .wednesday, .thursday]).description, "Monday, Tuesday, Wednesday, Thursday")
        XCTAssertEqual(Timetable(trips: [], days: [.friday, .saturday]).description, "Friday, Saturday")
        XCTAssertEqual(Timetable(trips: [], days: [.sunday, .holiday]).description, "Sunday, Holiday")
    }
}
