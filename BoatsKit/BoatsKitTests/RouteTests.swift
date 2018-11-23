import XCTest
@testable import BoatsKit

class RouteTests: XCTestCase {
    func testName() {
        XCTAssertEqual(Route.peaks.name, "Peaks Island")
        XCTAssertEqual(Route.cliff.name, "Cliff Island")
    }
    
    func testSchedule() {
        let date: Date = Date()
        var route: Route = Route.peaks
        route.append(schedule: Schedule(season: Season(name: .summer, dateInterval: DateInterval(start: Date(timeInterval: -60.0, since: date), end: Date(timeInterval: 60.0, since: date))), timetables: []))
        route.append(schedule: Schedule(season: Season(name: .fall, dateInterval: DateInterval(start: Date(timeInterval: 60.0, since: date), end: Date(timeInterval: 90.0, since: date))), timetables: []))
        XCTAssertEqual(route.schedules.count, 2)
        XCTAssertEqual(route.schedule(for: date)?.season.name, .summer)
        XCTAssertEqual(route.schedule()?.season.name, .summer)
        XCTAssertEqual(route.schedule(for: Date(timeInterval: 61.0, since: date))?.season.name, .fall)
        XCTAssertNil(route.schedule(for: Date(timeInterval: 120.0, since: date)))
        XCTAssertNil(route.schedule(for: Date(timeInterval: -61.0, since: date)))
    }
    
    func testScheduleAppend() {
        let date: Date = Date()
        var route: Route = Route.peaks
        XCTAssertTrue(route.schedules.isEmpty)
        XCTAssertFalse(route.append(schedule: Schedule(season: Season(name: .spring, dateInterval: DateInterval(start: Date(timeInterval: 0.0, since: date), end: Date(timeInterval: 0.0, since: date))), timetables: [])))
        XCTAssertTrue(route.schedules.isEmpty)
        XCTAssertTrue(route.append(schedule: Schedule(season: Season(name: .summer, dateInterval: DateInterval(start: Date(timeInterval: -60.0, since: date), end: Date(timeInterval: 60.0, since: date))), timetables: [])))
        XCTAssertEqual(route.schedules.count, 1)
        XCTAssertTrue(route.append(schedule: Schedule(season: Season(name: .fall, dateInterval: DateInterval(start: Date(timeInterval: 60.0, since: date), end: Date(timeInterval: 90.0, since: date))), timetables: [])))
        XCTAssertEqual(route.schedules.count, 2)
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
        XCTAssertEqual(Route.allCases, [Route.peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff])
    }
}

extension RouteTests {
    func testPeaks() {
        XCTAssertEqual(Route.peaks.location, .peaks)
        XCTAssertEqual(Route.peaks.uri, "peaks-island")
    }
    
    func testLittleDiamond() {
        XCTAssertEqual(Route.littleDiamond.location, .littleDiamond)
        XCTAssertEqual(Route.littleDiamond.uri, "little-diamond-island")
    }
    
    func testGreatDiamond() {
        XCTAssertEqual(Route.greatDiamond.location, .greatDiamond)
        XCTAssertEqual(Route.greatDiamond.uri, "great-diamond")
    }
    
    func testDiamondCove() {
        XCTAssertEqual(Route.diamondCove.location, .diamondCove)
        XCTAssertEqual(Route.diamondCove.uri, "diamond-cove")
    }
    
    func testLong() {
        XCTAssertEqual(Route.long.location, .long)
        XCTAssertEqual(Route.long.uri, "long-island")
    }
    
    func testChebeague() {
        XCTAssertEqual(Route.chebeague.location, .chebeague)
        XCTAssertEqual(Route.chebeague.uri, "chebeague-island")
    }
    
    func testCliff() {
        XCTAssertEqual(Route.cliff.location, .cliff)
        XCTAssertEqual(Route.cliff.uri, "cliff-island")
    }
    
    func testBailey() {
        XCTAssertEqual(Route.bailey.location, .bailey)
        XCTAssertEqual(Route.bailey.uri, "bailey-island")
    }
}
