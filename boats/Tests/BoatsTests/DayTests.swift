import Testing
@testable import Boats
import Foundation

struct DayTests {
    @Test func weekdays() {
        #expect(Day.weekdays == [.monday, .tuesday, .wednesday, .thursday, .friday])
    }
    
    @Test func week() {
        #expect(Day.week(beginning: .sunday) == [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday])
        #expect(Day.week(beginning: .monday) == [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday])
        #expect(Day.week(beginning: .tuesday) == [.tuesday, .wednesday, .thursday, .friday, .saturday, .sunday, .monday])
        #expect(Day.week(beginning: .wednesday) == [.wednesday, .thursday, .friday, .saturday, .sunday, .monday, .tuesday])
        #expect(Day.week(beginning: .thursday) == [.thursday, .friday, .saturday, .sunday, .monday, .tuesday, .wednesday])
        #expect(Day.week(beginning: .friday) == [.friday, .saturday, .sunday, .monday, .tuesday, .wednesday, .thursday])
        #expect(Day.week(beginning: .saturday) == [.saturday, .sunday, .monday, .tuesday, .wednesday, .thursday, .friday])
        #expect(Day.week().first == Day())
    }
    
    @Test func dateInit() {
        #expect(Day(Date(timeIntervalSince1970:  1524196800.0)) == .friday)
        #expect(Day(Date(timeIntervalSince1970:  1587355200.0)) == .monday)
    }
    
    // MARK: CustomAccessibilityStringConvertible
    @Test func accessibilityDescription() {
        #expect(Day.monday.accessibilityDescription == "Monday")
        #expect(Day.saturday.accessibilityDescription == "Saturday")
        #expect([Day.monday, .tuesday, .wednesday, .thursday].accessibilityDescription == "Monday through Thursday")
        #expect([Day.monday, .tuesday, .wednesday, .friday].accessibilityDescription == "Monday through Wednesday and Friday")
        #expect([Day.thursday, .friday, .saturday, .monday].accessibilityDescription == "Monday and Thursday through Saturday")
        #expect([Day.saturday, .sunday].accessibilityDescription == "Saturday and Sunday")
        #expect([Day.tuesday, .thursday, .friday].accessibilityDescription == "Tuesday and Thursday and Friday")
        #expect([Day.sunday, .tuesday].accessibilityDescription == "Tuesday and Sunday")
    }
    
    @Test func description() {
        #expect(Day.monday.description == "Mon")
        #expect(Day.saturday.description == "Sat")
        #expect([Day.monday, .tuesday, .wednesday, .thursday].description == "Mon-Thu")
        #expect([Day.monday, .tuesday, .wednesday, .friday].description == "Mon-Wed/Fri")
        #expect([Day.thursday, .friday, .saturday, .monday].description == "Mon/Thu-Sat")
        #expect([Day.saturday, .sunday].description == "Sat/Sun")
        #expect([Day.tuesday, .thursday, .friday].description == "Tue/Thu/Fri")
        #expect([Day.sunday, .tuesday].description == "Tue/Sun")
    }
}

extension DayTests {
    
    // MARK: HTMLConvertible
    @Test func htmlInit() throws {
        #expect(try Day(from: "Su") == .sunday)
        #expect(try Day(from: "Monday") == .monday)
        #expect(try Day(from: "Tues.") == .tuesday)
        #expect(try Day(from: "Wed") == .wednesday)
        #expect(try Day(from: "Thurs") == .thursday)
        #expect(try Day(from: "Friday") == .friday)
        #expect(try Day(from: "Sa.") == .saturday)
        #expect(throws: Error.self) {
            try Day(from: "Day")
        }
        #expect(throws: Error.self) {
            try Day(from: "S")
        }
    }
}
