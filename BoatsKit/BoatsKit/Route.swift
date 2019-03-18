import Foundation
import CoreLocation

public struct Route: Codable {
    public private(set) var location: Location
    public private(set) var schedules: [Schedule] = []
    public private(set) var services: [Service]
    public private(set) var uri: String
    
    public var name: String {
        return "\(location.name)"
    }
    
    public func schedule(for date: Date = Date()) -> Schedule? {
        for schedule in schedules {
            guard schedule.season.dateInterval.contains(date) else {
                continue
            }
            return schedule
        }
        return nil
    }
    
    @discardableResult public mutating func append(schedule: Schedule) -> Bool {
        guard schedule.season.dateInterval.end > Date() else {
            return false
        }
        schedules.append(schedule)
        return true
    }
    
    init(location: Location, services: [Service] = [], uri: String) {
        self.location = location
        self.services = services
        self.uri = uri
    }
}

extension Route: Equatable {
    
    // MARK: Equatable
    public static func ==(x: Route, y: Route) -> Bool {
        return x.uri == y.uri
    }
}

extension Route: CaseIterable {
    
    // MARK: CaseIterable
    public typealias AllCases = [Route]
    
    public static var allCases: AllCases {
        return [.peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff]
    }

}

extension Route {
    public static var peaks: Route {
        return Route(location: .peaks, services: [.car], uri: "peaks-island")
    }
    
    public static var littleDiamond: Route {
        return Route(location: .littleDiamond, uri: "little-diamond-island")
    }
    
    public static var greatDiamond: Route {
        return Route(location: .greatDiamond, uri: "great-diamond")
    }
    
    public static var diamondCove: Route {
        return Route(location: .diamondCove, uri: "diamond-cove")
    }
    
    public static var long: Route {
        return Route(location: .long, uri: "long-island")
    }
    
    public static var chebeague: Route {
        return Route(location: .chebeague, uri: "chebeague-island")
    }
    
    public static var cliff: Route {
        return Route(location: .cliff, uri: "cliff-island")
    }
    
    public static var bailey: Route {
        return Route(location: .bailey, uri: "bailey-island")
    }
}
