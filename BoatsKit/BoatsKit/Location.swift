import Foundation
import CoreLocation

public struct Location: CustomStringConvertible, Codable {
    public private(set) var coordinate: CLLocationCoordinate2D
    public private(set) var name: String
    public private(set) var description: String
    
    public init(coordinate: CLLocationCoordinate2D, name: String, description: String) {
        self.coordinate = coordinate
        self.name = name
        self.description = description
    }
}
