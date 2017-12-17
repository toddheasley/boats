import Foundation

public struct Coordinate: Codable {
    public private(set) var latitude: Double = 0.0
    public private(set) var longitude: Double = 0.0
    
    public init(_ latitude: Double, _ longitude: Double) {
        self.latitude = min(max(latitude, -85.0), 85.0)
        self.longitude = min(max(longitude, -180.0), 180.0)
    }
}
