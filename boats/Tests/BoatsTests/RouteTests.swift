import XCTest
@testable import Boats

class RouteTests: XCTestCase {
    func testSchedule() {
        let date: Date = Date()
        var route: Route = Route.peaks
        route.include(schedule: Schedule(season: Season(.summer, dateInterval: DateInterval(start: Date(timeInterval: -60.0, since: date), end: Date(timeInterval: 60.0, since: date))), timetables: []))
        route.include(schedule: Schedule(season: Season(.fall, dateInterval: DateInterval(start: Date(timeInterval: 60.0, since: date), end: Date(timeInterval: 90.0, since: date))), timetables: []))
        XCTAssertEqual(route.schedules.count, 2)
        XCTAssertEqual(route.schedule(for: date)?.season.name, .summer)
        XCTAssertEqual(route.schedule()?.season.name, .summer)
        XCTAssertEqual(route.schedule(for: Date(timeInterval: 61.0, since: date))?.season.name, .fall)
        XCTAssertNil(route.schedule(for: Date(timeInterval: 120.0, since: date)))
        XCTAssertNil(route.schedule(for: Date(timeInterval: -61.0, since: date)))
    }
    
    func testScheduleInsert() {
        let date: Date = Date()
        var route: Route = Route.peaks
        XCTAssertTrue(route.schedules.isEmpty)
        XCTAssertFalse(route.include(schedule: Schedule(season: Season(.spring, dateInterval: DateInterval(start: Date(timeInterval: 0.0, since: date), end: Date(timeInterval: 0.0, since: date))), timetables: [])))
        XCTAssertTrue(route.schedules.isEmpty)
        XCTAssertTrue(route.include(schedule: Schedule(season: Season(.summer, dateInterval: DateInterval(start: Date(timeInterval: -60.0, since: date), end: Date(timeInterval: 60.0, since: date))), timetables: [])))
        XCTAssertEqual(route.schedules.count, 1)
        XCTAssertTrue(route.include(schedule: Schedule(season: Season(.fall, dateInterval: DateInterval(start: Date(timeInterval: 60.0, since: date), end: Date(timeInterval: 90.0, since: date))), timetables: [])))
        XCTAssertEqual(route.schedules.count, 2)
    }
    
    // MARK: StringConvertible
    func testDescription() {
        XCTAssertEqual(Route.peaks.description, "Peaks Island")
        XCTAssertEqual(Route.chebeague.description, "Chebeague Island")
        XCTAssertEqual(Route.bailey.description, "Bailey Island")
    }
}

extension RouteTests {
    
    // MARK: Equatable
    func testEqual() {
        XCTAssertNotEqual(Route.peaks, .chebeague)
        XCTAssertEqual(Route.peaks, .peaks)
    }
}

extension RouteTests {
    
    // MARK: CaseIterable
    func testAllCases() {
        XCTAssertEqual(Route.allCases, [.peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff])
    }
}
