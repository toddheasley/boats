import Foundation
import CoreLocation

public struct Location: CustomStringConvertible, Codable {
    public let coordinate: CLLocationCoordinate2D
    public let name: String
    public let description: String
    
    public var abbreviated: String {
        return name.replacingOccurrences(of: " Island", with: "")
    }
}

extension Location: Equatable {
    
    // MARK: Equatable
    public static func ==(x: Location, y: Location) -> Bool {
        return x.coordinate == y.coordinate
    }
}

extension Location: CaseIterable {
    
    // MARK: CaseIterable
    public typealias AllCases = [Location]
    
    public static var allCases: AllCases {
        return [.portland, .peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff]
    }
    
}

extension Location {
    public static var portland: Location {
        return Location(coordinate: CLLocationCoordinate2D(latitude: 43.656513, longitude: -70.248247), name: "Portland", description: "Casco Bay Lines Ferry Terminal")
    }
    
    public static var peaks: Location {
        return Location(coordinate: CLLocationCoordinate2D(latitude: 43.655520, longitude: -70.199316), name: "Peaks Island", description: "Forest City Landing")
    }
    
    public static var littleDiamond: Location {
        return Location(coordinate: CLLocationCoordinate2D(latitude: 43.662774, longitude: -70.209585), name: "Little Diamond Island", description: "Little Diamond Island Landing")
    }
    
    public static var greatDiamond: Location {
        return Location(coordinate: CLLocationCoordinate2D(latitude: 43.670750, longitude: -70.199691), name: "Great Diamond Island", description: "Great Diamond Island Landing")
    }
    
    public static var diamondCove: Location {
        return Location(coordinate: CLLocationCoordinate2D(latitude: 43.684715, longitude: -70.191293), name: "Diamond Cove", description: "McKinley Estates Landing")
    }
    
    public static var long: Location {
        return Location(coordinate: CLLocationCoordinate2D(latitude: 43.691359, longitude: -70.164709), name: "Long Island", description: "Mariner's Landing")
    }
    
    public static var chebeague: Location {
        return Location(coordinate: CLLocationCoordinate2D(latitude: 43.715991, longitude: -70.126120), name: "Chebeague Island", description: "Chandlers Cove Landing")
    }
    
    public static var cliff: Location {
        return Location(coordinate: CLLocationCoordinate2D(latitude: 43.694900, longitude: -70.109666), name: "Cliff Island", description: "Cliff Island Landing")
    }
    
    public static var bailey: Location {
        return Location(coordinate: CLLocationCoordinate2D(latitude: 43.748963, longitude: -69.991044), name: "Bailey Island", description: "Cook's Landing")
    }
}
