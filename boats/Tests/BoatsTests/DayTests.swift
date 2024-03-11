import XCTest
@testable import Boats

class DayTests: XCTestCase {
    func testWeekdays() {
        XCTAssertEqual(Day.weekdays, [.monday, .tuesday, .wednesday, .thursday, .friday])
    }
    
    func testWeek() {
        XCTAssertEqual(Day.week(beginning: .sunday), [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday])
        XCTAssertEqual(Day.week(beginning: .monday), [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday])
        XCTAssertEqual(Day.week(beginning: .tuesday), [.tuesday, .wednesday, .thursday, .friday, .saturday, .sunday, .monday])
        XCTAssertEqual(Day.week(beginning: .wednesday), [.wednesday, .thursday, .friday, .saturday, .sunday, .monday, .tuesday])
        XCTAssertEqual(Day.week(beginning: .thursday), [.thursday, .friday, .saturday, .sunday, .monday, .tuesday, .wednesday])
        XCTAssertEqual(Day.week(beginning: .friday), [.friday, .saturday, .sunday, .monday, .tuesday, .wednesday, .thursday])
        XCTAssertEqual(Day.week(beginning: .saturday), [.saturday, .sunday, .monday, .tuesday, .wednesday, .thursday, .friday])
        XCTAssertEqual(Day.week().first, Day())
    }
    
    func testDateInit() {
        XCTAssertEqual(Day(Date(timeIntervalSince1970:  1524196800.0)), .friday)
        XCTAssertEqual(Day(Date(timeIntervalSince1970:  1587355200.0)), .monday)
    }
    
    // MARK: CustomAccessibilityStringConvertible
    func testAccessibilityDescription() {
        XCTAssertEqual(Day.monday.accessibilityDescription, "Monday")
        XCTAssertEqual(Day.saturday.accessibilityDescription, "Saturday")
        XCTAssertEqual([Day.monday, .tuesday, .wednesday, .thursday].accessibilityDescription, "Monday through Thursday")
        XCTAssertEqual([Day.monday, .tuesday, .wednesday, .friday].accessibilityDescription, "Monday through Wednesday and Friday")
        XCTAssertEqual([Day.thursday, .friday, .saturday, .monday].accessibilityDescription, "Monday and Thursday through Saturday")
        XCTAssertEqual([Day.saturday, .sunday].accessibilityDescription, "Saturday and Sunday")
        XCTAssertEqual([Day.tuesday, .thursday, .friday].accessibilityDescription, "Tuesday and Thursday and Friday")
        XCTAssertEqual([Day.sunday, .tuesday].accessibilityDescription, "Tuesday and Sunday")
    }
    
    func testDescription() {
        XCTAssertEqual(Day.monday.description, "Mon")
        XCTAssertEqual(Day.saturday.description, "Sat")
        XCTAssertEqual([Day.monday, .tuesday, .wednesday, .thursday].description, "Mon-Thu")
        XCTAssertEqual([Day.monday, .tuesday, .wednesday, .friday].description, "Mon-Wed/Fri")
        XCTAssertEqual([Day.thursday, .friday, .saturday, .monday].description, "Mon/Thu-Sat")
        XCTAssertEqual([Day.saturday, .sunday].description, "Sat/Sun")
        XCTAssertEqual([Day.tuesday, .thursday, .friday].description, "Tue/Thu/Fri")
        XCTAssertEqual([Day.sunday, .tuesday].description, "Tue/Sun")
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
        XCTAssertNil(try? Day(from: "Day"))
        XCTAssertNil(try? Day(from: "S"))
    }
}
