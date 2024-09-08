import Testing
@testable import Boats
import Foundation

struct DateFormatterTests {
    @Test func is24Hour() {
        DateFormatter.clockFormat = .twelveHour
        #expect(!DateFormatter.is24Hour)
        DateFormatter.clockFormat = .system
    }
    
    @Test func dateIntervalAccessibilityDescription() {
        #expect(DateFormatter.accessibilityDescription(from: DateInterval(start: Date(timeIntervalSince1970: 1523678400.0), end: Date(timeIntervalSince1970: 1529121599.9))) == "April 14 through June 15, 2018")
        #expect(DateFormatter.accessibilityDescription(from: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))) == "June 16 through September 3, 2018")
        #expect(DateFormatter.accessibilityDescription(from: DateInterval(start: Date(timeIntervalSince1970: 1536033600.0), end: Date(timeIntervalSince1970: 1539057599.9))) == "September 4 through October 8, 2018")
        #expect(DateFormatter.accessibilityDescription(from: DateInterval(start: Date(timeIntervalSince1970: 1539057600), end: Date(timeIntervalSince1970: 1546664399.9))) == "October 9, 2018 through January 4, 2019")
    }
    
    @Test func dateIntervalDescription() {
        #expect(DateFormatter.description(from: DateInterval(start: Date(timeIntervalSince1970: 1523678400.0), end: Date(timeIntervalSince1970: 1529121599.9))) == "Apr 14-Jun 15, 2018")
        #expect(DateFormatter.description(from: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))) == "Jun 16-Sep 3, 2018")
        #expect(DateFormatter.description(from: DateInterval(start: Date(timeIntervalSince1970: 1536033600.0), end: Date(timeIntervalSince1970: 1539057599.9))) == "Sep 4-Oct 8, 2018")
        #expect(DateFormatter.description(from: DateInterval(start: Date(timeIntervalSince1970: 1539057600), end: Date(timeIntervalSince1970: 1546664399.9))) == "Oct 9, 2018-Jan 4, 2019")
    }
    
    @Test func dateDescription() {
        #expect(DateFormatter.description(from: Date(timeIntervalSince1970: 1523678400.0)) == "Apr 14")
        #expect(DateFormatter.description(from: Date(timeIntervalSince1970: 1536033600.0)) == "Sep 4")
    }
    
    @Test func time() {
        #expect(DateFormatter.time(from: Date(timeIntervalSince1970: 1541303999.0)) == Time(hour: 23, minute: 59))
        #expect(DateFormatter.time(from: Date(timeIntervalSince1970: 1541304000.0)) == Time(hour: 0, minute: 0))
        #expect(DateFormatter.time(from: Date(timeIntervalSince1970: 1541316600.0)) == Time(hour: 2, minute: 30))
    }
    
    @Test func componentsNext() {
        #expect(DateFormatter.next(in: [(2018, 4, 20), (2019, 4, 20)], from: Date(timeIntervalSince1970: 1524196800.0)) == Date(timeIntervalSince1970: 1524196800.0))
        #expect(DateFormatter.next(in: [(2018, 4, 20), (2019, 4, 20)], from: Date(timeIntervalSince1970: 1524196801.0)) == Date(timeIntervalSince1970: 1555732800.0))
        #expect(DateFormatter.next(in: [(2018, 4, 20), (2019, 4, 20)], from: Date(timeIntervalSince1970: 1555732801.0)) == Date(timeIntervalSince1970: 0.0))
        #expect(DateFormatter.next(in: [], from: Date()) == Date(timeIntervalSince1970: 0.0))
    }
    
    @Test func monthDayNext() {
        #expect(DateFormatter.next(month: 4, day: 20, from: Date()) == DateFormatter.next(month: 4, day: 20))
        #expect(DateFormatter.next(month: 4, day: 20, from: Date(timeIntervalSince1970: 1555732800.0)) == Date(timeIntervalSince1970: 1555732800.0))
        #expect(DateFormatter.next(month: 4, day: 20, from: Date(timeIntervalSince1970: 1555732801.0)) == Date(timeIntervalSince1970: 1587355200.0))
    }
    
    @Test func day() {
        #expect(DateFormatter.day(from: Date(timeIntervalSince1970:  1524196800.0)) == .friday)
        #expect(DateFormatter.day(from: Date(timeIntervalSince1970:  1587355200.0)) == .monday)
    }
    
    @Test func year() {
        #expect(DateFormatter.year(from: Date(timeIntervalSince1970: 1524196800.0)) == 2018)
        #expect(DateFormatter.year(from: Date(timeIntervalSince1970: 1587355200.0)) == 2020)
    }
}
