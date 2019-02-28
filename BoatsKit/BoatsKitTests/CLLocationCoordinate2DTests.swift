import XCTest
import CoreLocation
@testable import BoatsKit

class CLLocationCoordinate2DTests: XCTestCase {
    
}

extension CLLocationCoordinate2DTests {
    
    // MARK: Equatable
    func testEqual() {
        XCTAssertNotEqual(CLLocationCoordinate2D(latitude: 43.6576798, longitude: -70.2481828), CLLocationCoordinate2D(latitude: 43.6576798, longitude: -70.192580))
        XCTAssertNotEqual(CLLocationCoordinate2D(latitude: 43.6576798, longitude: -70.2481828), CLLocationCoordinate2D(latitude: 43.684156, longitude: -70.2481828))
        XCTAssertEqual(CLLocationCoordinate2D(latitude: 43.6576798, longitude: -70.2481828), CLLocationCoordinate2D(latitude: 43.6576798, longitude: -70.2481828))
    }
}

extension CLLocationCoordinate2DTests {
    
    // MARK: Codable
    func testDecodeInit() {
        guard let data: Data = data(resource: .bundle, type: "json"),
            let coordinates: [CLLocationCoordinate2D] = try? JSONDecoder.shared.decode([CLLocationCoordinate2D].self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(coordinates.count, 9)
        XCTAssertEqual(coordinates.first,  CLLocationCoordinate2D(latitude: 43.656513, longitude: -70.248247))
        XCTAssertEqual(coordinates.last,  CLLocationCoordinate2D(latitude: 43.748963, longitude: -69.991044))
    }
    
    func testEncode() {
        guard let data: Data = try? JSONEncoder.shared.encode(CLLocationCoordinate2D(latitude: 43.655520, longitude: -70.199316)),
            let coordinate: CLLocationCoordinate2D = try? JSONDecoder.shared.decode(CLLocationCoordinate2D.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(coordinate, CLLocationCoordinate2D(latitude: 43.655520, longitude: -70.199316))
    }
}
