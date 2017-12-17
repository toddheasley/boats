import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    public init(coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
