import Testing
@testable import Boats
import Foundation

struct RouteTests {
    @Test func schedule() {
        let date: Date = Date()
        var route: Route = Route.peaks
        route.include(schedule: Schedule(season: Season(.summer, dateInterval: DateInterval(start: Date(timeInterval: -60.0, since: date), end: Date(timeInterval: 60.0, since: date))), timetables: []))
        route.include(schedule: Schedule(season: Season(.fall, dateInterval: DateInterval(start: Date(timeInterval: 60.0, since: date), end: Date(timeInterval: 90.0, since: date))), timetables: []))
        #expect(route.schedules.count == 2)
        #expect(route.schedule(for: date)?.season.name == .summer)
        #expect(route.schedule()?.season.name == .summer)
        #expect(route.schedule(for: Date(timeInterval: 61.0, since: date))?.season.name == .fall)
        #expect(route.schedule(for: Date(timeInterval: 120.0, since: date)) == nil)
        #expect(route.schedule(for: Date(timeInterval: -61.0, since: date)) == nil)
    }
    
    @Test func scheduleInsert() {
        let date: Date = Date()
        var route: Route = Route.peaks
        #expect(route.schedules.isEmpty)
        route.include(schedule: Schedule(season: Season(.spring, dateInterval: DateInterval(start: Date(timeInterval: 0.0, since: date), end: Date(timeInterval: 0.0, since: date))), timetables: []))
        #expect(route.schedules.isEmpty)
        route.include(schedule: Schedule(season: Season(.summer, dateInterval: DateInterval(start: Date(timeInterval: -60.0, since: date), end: Date(timeInterval: 60.0, since: date))), timetables: []))
        #expect(route.schedules.count == 1)
        route.include(schedule: Schedule(season: Season(.fall, dateInterval: DateInterval(start: Date(timeInterval: 60.0, since: date), end: Date(timeInterval: 90.0, since: date))), timetables: []))
        #expect(route.schedules.count == 2)
    }
    
    // MARK: StringConvertible
    @Test func description() {
        #expect(Route.peaks.description == "Peaks Island")
        #expect(Route.chebeague.description == "Chebeague Island")
        #expect(Route.bailey.description == "Bailey Island")
    }
}

extension RouteTests {
    
    // MARK: Equatable
    @Test func equal() {
        #expect(Route.peaks != .chebeague)
        #expect(Route.peaks == .peaks)
    }
}

extension RouteTests {
    
    // MARK: CaseIterable
    @Test func allCases() {
        #expect(Route.allCases == [.peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff])
    }
}
