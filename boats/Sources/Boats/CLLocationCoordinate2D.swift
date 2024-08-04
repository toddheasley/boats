import CoreLocation

extension CLLocationCoordinate2D: @retroactive CustomStringConvertible, CustomAccessibilityStringConvertible, @retroactive Equatable {
    
    // MARK: CustomAccessibilityStringConvertible
    public var accessibilityDescription: String { String(format: "%.5f° latitude, %.5f° longitude", latitude, longitude) }
    public var description: String { String(format: "%.5f°, %.5f°", latitude, longitude) }
    
    // MARK: Equatable
    public static func ==(x: Self, y: Self) -> Bool {
        x.accessibilityDescription == y.accessibilityDescription
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

extension CLLocationCoordinate2D: @retroactive CaseIterable {
    public static let portland: Self = Self(latitude: 43.65651, longitude: -70.24825)
    public static let peaks: Self = Self(latitude: 43.65552, longitude: -70.19932)
    public static let littleDiamond: Self = Self(latitude: 43.66277, longitude: -70.20959)
    public static let greatDiamond: Self = Self(latitude: 43.67075, longitude: -70.19969)
    public static let diamondCove: Self = Self(latitude: 43.68472, longitude: -70.19129)
    public static let long: Self = Self(latitude: 43.69136, longitude: -70.16471)
    public static let chebeague: Self = Self(latitude: 43.71599, longitude: -70.12612)
    public static let cliff: Self = Self(latitude: 43.69490, longitude: -70.10967)
    public static let bailey: Self = Self(latitude: 43.74896, longitude: -69.99104)
    
    // MARK: CaseIterable
    public static let allCases: [Self] = [.portland, .peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff, .bailey]
}
