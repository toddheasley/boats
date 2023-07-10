import Foundation

public struct Route: Codable, CustomStringConvertible {
    public let location: Location
    public let services: [Service]
    public let uri: String
    public private(set) var schedules: [Schedule] = []
    
    public func schedule(for date: Date = Date()) -> Schedule? {
        for schedule in schedules {
            guard schedule.season.dateInterval.contains(date) else {
                continue
            }
            return schedule
        }
        return nil
    }
    
    @discardableResult public mutating func include(schedule: Schedule) -> Bool {
        guard schedule.season.dateInterval.end > Date() else {
            return false
        }
        schedules.append(schedule)
        schedules = schedules.sorted()
        return true
    }
    
    init(location: Location, services: [Service] = [], uri: String) {
        self.location = location
        self.services = services
        self.uri = uri
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return location.name
    }
}

extension Route: Equatable, Identifiable {
    
    // MARK: Equatable
    public static func ==(x: Self, y: Self) -> Bool {
        return x.uri == y.uri
    }
    
    // MARK: Identifiable
    public var id: String {
        return uri
    }
}

extension Route: CaseIterable {
    public static let peaks: Self = Self(location: .peaks, services: [.car], uri: "peaks-island")
    public static let littleDiamond: Self = Self(location: .littleDiamond, uri: "little-diamond-island")
    public static let greatDiamond: Self = Self(location: .greatDiamond, uri: "great-diamond")
    public static let diamondCove: Self = Self(location: .diamondCove, uri: "diamond-cove")
    public static let long: Self = Self(location: .long, uri: "long-island")
    public static let chebeague: Self = Self(location: .chebeague, uri: "chebeague-island")
    public static let cliff: Self = Self(location: .cliff, uri: "cliff-island")
    public static let bailey: Self = Self(location: .bailey, uri: "bailey-island")
    
    // MARK: CaseIterable
    public static let allCases: [Self] = [.peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff]
}
