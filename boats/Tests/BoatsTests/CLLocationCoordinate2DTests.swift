import XCTest
import CoreLocation
@testable import Boats

class CLLocationCoordinate2DTests: XCTestCase {
    
}

extension CLLocationCoordinate2DTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(CLLocationCoordinate2D.portland.description, "43.65651°, -70.24825°")
        XCTAssertEqual(CLLocationCoordinate2D.peaks.description, "43.65552°, -70.19932°")
        XCTAssertEqual(CLLocationCoordinate2D.littleDiamond.description, "43.66277°, -70.20959°")
        XCTAssertEqual(CLLocationCoordinate2D.greatDiamond.description, "43.67075°, -70.19969°")
        XCTAssertEqual(CLLocationCoordinate2D.diamondCove.description, "43.68472°, -70.19129°")
        XCTAssertEqual(CLLocationCoordinate2D.long.description, "43.69136°, -70.16471°")
        XCTAssertEqual(CLLocationCoordinate2D.chebeague.description, "43.71599°, -70.12612°")
        XCTAssertEqual(CLLocationCoordinate2D.cliff.description, "43.69490°, -70.10967°")
        XCTAssertEqual(CLLocationCoordinate2D.bailey.description, "43.74896°, -69.99104°")
    }
    
    // MARK: Equatable
    func testEqual() {
        XCTAssertNotEqual(CLLocationCoordinate2D(latitude: 43.655514, longitude: -70.19932), .peaks)
        XCTAssertNotEqual(CLLocationCoordinate2D(latitude: 43.65552, longitude: -70.199325), .peaks)
        XCTAssertEqual(CLLocationCoordinate2D(latitude: 43.65552, longitude: -70.199317), .peaks)
        XCTAssertEqual(CLLocationCoordinate2D(latitude: 43.655524, longitude: -70.19932), .peaks)
    }
}

extension CLLocationCoordinate2DTests {
    
    // MARK: Codable
    func testDecoderInit() throws {
        let data: Data = try JSONEncoder().encode(CLLocationCoordinate2D.chebeague)
        let coordinate: CLLocationCoordinate2D = try JSONDecoder().decode(CLLocationCoordinate2D.self, from: data)
        XCTAssertEqual(coordinate.latitude, 43.71599)
        XCTAssertEqual(coordinate.longitude, -70.12612)
    }
    
    func testEncode() throws {
        try testDecoderInit()
    }
}

extension CLLocationCoordinate2DTests {
    
    // MARK: CaseIterable
    func testAllCases() {
        XCTAssertEqual(CLLocationCoordinate2D.allCases, [.portland, .peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff, .bailey])
    }
}
