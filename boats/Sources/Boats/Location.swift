import CoreLocation

public struct Location: Codable, CustomStringConvertible {
    public let coordinate: CLLocationCoordinate2D
    public let name: String
    
    public var nickname: String {
        return name.replacingOccurrences(of: " Island", with: "")
    }
    
    init(_ name: String, description: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.description = description
        self.coordinate = coordinate
    }
    
    // MARK: CustomStringConvertible
    public let description: String
}

extension Location: Equatable {
    
    // MARK: Equatable
    public static func ==(x: Self, y: Self) -> Bool {
        return x.coordinate == y.coordinate
    }
}

extension Location: CaseIterable {
    public static let portland: Self = Self("Portland", description: "Casco Bay Lines Ferry Terminal", coordinate: .portland)
    public static let peaks: Self = Self("Peaks Island", description: "Forest City Landing", coordinate: .peaks)
    public static let littleDiamond: Self = Self("Little Diamond Island", description: "Little Diamond Island Landing", coordinate: .littleDiamond)
    public static let greatDiamond: Self = Self("Great Diamond Island", description: "Great Diamond Island Landing", coordinate: .greatDiamond)
    public static let diamondCove: Self = Self("Diamond Cove", description: "McKinley Estates Landing", coordinate: .diamondCove)
    public static let long: Self = Self("Long Island", description: "Mariner's Landing", coordinate: .long)
    public static let chebeague: Self = Self("Chebeague Island", description: "Chandlers Cove Landing", coordinate: .chebeague)
    public static let cliff: Self = Self("Cliff Island", description: "Cliff Island Landing", coordinate: .cliff)
    public static let bailey: Self = Self("Bailey Island", description: "Cook's Landing", coordinate: .bailey)
    
    // MARK: CaseIterable
    public static let allCases: [Self] = [.portland, .peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff, .bailey]
}
