import XCTest
@testable import Boats

class DayTests: XCTestCase {
    func testWeek() {
        XCTAssertEqual(Day.week(beginning: .sunday), [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday])
        XCTAssertEqual(Day.week(beginning: .monday), [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday])
        XCTAssertEqual(Day.week(beginning: .tuesday), [.tuesday, .wednesday, .thursday, .friday, .saturday, .sunday, .monday])
        XCTAssertEqual(Day.week(beginning: .wednesday), [.wednesday, .thursday, .friday, .saturday, .sunday, .monday, .tuesday])
        XCTAssertEqual(Day.week(beginning: .thursday), [.thursday, .friday, .saturday, .sunday, .monday, .tuesday, .wednesday])
        XCTAssertEqual(Day.week(beginning: .friday), [.friday, .saturday, .sunday, .monday, .tuesday, .wednesday, .thursday])
        XCTAssertEqual(Day.week(beginning: .saturday), [.saturday, .sunday, .monday, .tuesday, .wednesday, .thursday, .friday])
        XCTAssertEqual(Day.week(beginning: .holiday).first, Day())
        XCTAssertEqual(Day.week().first, Day())
    }
    
    func testDateInit() {
        XCTAssertEqual(Day(Date(timeIntervalSince1970:  1524196800.0)), .friday)
        XCTAssertEqual(Day(Date(timeIntervalSince1970:  1587355200.0)), .monday)
    }
    
    // MARK: StringConvertible
    func testDescription() {
        XCTAssertEqual(Day.sunday.description(.title), "Sunday")
        XCTAssertEqual(Day.sunday.description(.sentence), "Sunday")
        XCTAssertEqual(Day.sunday.description(.abbreviated), "Sun")
        XCTAssertEqual(Day.sunday.description(.compact), "sun")
        XCTAssertEqual(Day.thursday.description(.title), "Thursday")
        XCTAssertEqual(Day.thursday.description(.sentence), "Thursday")
        XCTAssertEqual(Day.thursday.description(.abbreviated), "Thu")
        XCTAssertEqual(Day.thursday.description(.compact), "thu")
    }
}

extension DayTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() {
        XCTAssertEqual(try? Day(from: "Su"), .sunday)
        XCTAssertEqual(try? Day(from: "Monday"), .monday)
        XCTAssertEqual(try? Day(from: "Tues."), .tuesday)
        XCTAssertEqual(try? Day(from: "Wed"), .wednesday)
        XCTAssertEqual(try? Day(from: "Thurs"), .thursday)
        XCTAssertEqual(try? Day(from: "Friday"), .friday)
        XCTAssertEqual(try? Day(from: "Sa."), .saturday)
        XCTAssertEqual(try? Day(from: "Holidoy"), .holiday)
        XCTAssertNil(try? Day(from: "Day"))
        XCTAssertNil(try? Day(from: "S"))
    }
}
