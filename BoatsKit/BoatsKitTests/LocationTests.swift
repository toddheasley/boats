import XCTest
import CoreLocation
@testable import BoatsKit

class LocationTests: XCTestCase {
    
    // MARK: Codable
    func testDecodeInit() {
        guard let data: Data = data(resource: .bundle, type: "json"), let locations: [Location] = try? JSONDecoder().decode([Location].self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(locations.count, 9)
        XCTAssertEqual(locations.first?.coordinate, CLLocationCoordinate2D(latitude: 43.655520, longitude: -70.199316))
        XCTAssertEqual(locations.first?.name, "Peaks Island")
        XCTAssertEqual(locations.first?.description, "Forest City Landing")
        XCTAssertEqual(locations.last?.coordinate, CLLocationCoordinate2D(latitude: 43.656513, longitude: -70.248247))
        XCTAssertEqual(locations.last?.name, "Portland")
        XCTAssertEqual(locations.last?.description, "Casco Bay Lines Ferry Terminal")
    }
    
    func testEncode() {
        guard let data: Data = try? JSONEncoder().encode(Location(coordinate: CLLocationCoordinate2D(latitude: 43.655520, longitude: -70.199316), name: "Peaks Island", description: "Forest City Landing")), let location: Location = try? JSONDecoder().decode(Location.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(location.coordinate, CLLocationCoordinate2D(latitude: 43.655520, longitude: -70.199316))
        XCTAssertEqual(location.name, "Peaks Island")
        XCTAssertEqual(location.description, "Forest City Landing")
    }
}
