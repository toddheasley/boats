import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    public static let null: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
}

extension CLLocationCoordinate2D: Equatable {
    
    // MARK: Equatable
    public static func ==(x: CLLocationCoordinate2D, y: CLLocationCoordinate2D) -> Bool {
        return x.latitude == y.latitude && x.longitude == y.longitude
    }
}

extension CLLocationCoordinate2D: Codable {
    
    // MARK: Codable
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        self.init(latitude: try container.decode(Double.self, forKey: .latitude), longitude: try container.decode(Double.self, forKey: .longitude))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    private enum Key: CodingKey {
        case latitude, longitude
    }
}
