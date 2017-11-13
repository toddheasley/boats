//
// © 2017 @toddheasley
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    public init() {
        self.init(latitude: 0.0, longitude: 0.0)
    }
}

extension CLLocationCoordinate2D: Codable {
    private enum Key: CodingKey {
        case latitude
        case longitude
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode("\(latitude)", forKey: .latitude)
        try container.encode("\(longitude)", forKey: .longitude)
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        self.init(latitude: CLLocationDegrees(try container.decode(String.self, forKey: .latitude)) ?? 0.0, longitude: CLLocationDegrees(try container.decode(String.self, forKey: .longitude)) ?? 0.0)
    }
}
