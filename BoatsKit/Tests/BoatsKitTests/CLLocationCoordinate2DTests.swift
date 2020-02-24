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
    func testDecoderInit() {
        guard let coordinates: [CLLocationCoordinate2D] = try? JSONDecoder.shared.decode([CLLocationCoordinate2D].self, from: JSON_Data) else {
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

private let JSON_Data: Data = """
[
    {
        "latitude": 43.656513,
        "longitude": -70.248247
    },
    {
        "latitude": 43.655520,
        "longitude": -70.199316
    },
    {
        "latitude": 43.662774,
        "longitude": -70.209585
    },
    {
        "latitude": 43.670750,
        "longitude": -70.199691
    },
    {
        "latitude": 43.684715,
        "longitude": -70.191293
    },
    {
        "latitude": 43.691359,
        "longitude": -70.164709
    },
    {
        "latitude": 43.715991,
        "longitude": -70.126120
    },
    {
        "latitude": 43.694900,
        "longitude": -70.109666
    },
    {
        "latitude": 43.748963,
        "longitude": -69.991044
    }
]
""".data(using: .utf8)!
