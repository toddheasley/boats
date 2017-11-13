//
// © 2017 @toddheasley
//

import Foundation
import CoreLocation

public struct Location: Codable {
    public var name: String = ""
    public var description: String = ""
    public var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    public init() {
        
    }
}
