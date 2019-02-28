import XCTest
import CoreLocation
@testable import BoatsKit

class LocationTests: XCTestCase {
    
    // MARK: Codable
    func testDecodeInit() {
        guard let data: Data = data(resource: .bundle, type: "json"),
            let locations: [Location] = try? JSONDecoder.shared.decode([Location].self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(locations.count, 9)
        XCTAssertEqual(locations.first?.coordinate, CLLocationCoordinate2D(latitude: 43.656513, longitude: -70.248247))
        XCTAssertEqual(locations.first?.name, "Portland")
        XCTAssertEqual(locations.first?.description, "Casco Bay Lines Ferry Terminal")
        XCTAssertEqual(locations.last?.coordinate, CLLocationCoordinate2D(latitude: 43.748963, longitude: -69.991044))
        XCTAssertEqual(locations.last?.name, "Bailey Island")
        XCTAssertEqual(locations.last?.description, "Cook's Landing")
    }
    
    func testEncode() {
        guard let data: Data = try? JSONEncoder.shared.encode(Location(coordinate: CLLocationCoordinate2D(latitude: 43.655520, longitude: -70.199316), name: "Peaks Island", description: "Forest City Landing")),
            let location: Location = try? JSONDecoder.shared.decode(Location.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(location.coordinate, CLLocationCoordinate2D(latitude: 43.655520, longitude: -70.199316))
        XCTAssertEqual(location.name, "Peaks Island")
        XCTAssertEqual(location.description, "Forest City Landing")
    }
}

extension LocationTests {
    
    // MARK: Equatable
    func testEqual() {
        XCTAssertNotEqual(Location.peaks, .portland)
        XCTAssertEqual(Location.peaks, .peaks)
    }
}

extension LocationTests {
    
    // MARK: CaseIterable
    func testAllCases() {
        XCTAssertEqual(Location.allCases, [Location.portland, .peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff])
    }
}

extension LocationTests {
    func testPortland() {
        XCTAssertEqual(Location.portland.coordinate, CLLocationCoordinate2D(latitude: 43.656513, longitude: -70.248247))
        XCTAssertEqual(Location.portland.name, "Portland")
        XCTAssertEqual(Location.portland.description, "Casco Bay Lines Ferry Terminal")
    }
    
    func testPeaks() {
        XCTAssertEqual(Location.peaks.coordinate, CLLocationCoordinate2D(latitude: 43.655520, longitude: -70.199316))
        XCTAssertEqual(Location.peaks.name, "Peaks Island")
        XCTAssertEqual(Location.peaks.description, "Forest City Landing")
    }
    
    func testLittleDiamond() {
        XCTAssertEqual(Location.littleDiamond.coordinate, CLLocationCoordinate2D(latitude: 43.662774, longitude: -70.209585))
        XCTAssertEqual(Location.littleDiamond.name, "Little Diamond Island")
        XCTAssertEqual(Location.littleDiamond.description, "Little Diamond Island Landing")
    }
    
    func testGreatDiamond() {
        XCTAssertEqual(Location.greatDiamond.coordinate, CLLocationCoordinate2D(latitude: 43.670750, longitude: -70.199691))
        XCTAssertEqual(Location.greatDiamond.name, "Great Diamond Island")
        XCTAssertEqual(Location.greatDiamond.description, "Great Diamond Island Landing")
    }
    
    func testDiamondCove() {
        XCTAssertEqual(Location.diamondCove.coordinate, CLLocationCoordinate2D(latitude: 43.684715, longitude: -70.191293))
        XCTAssertEqual(Location.diamondCove.name, "Diamond Cove")
        XCTAssertEqual(Location.diamondCove.description, "McKinley Estates Landing")
    }
    
    func testLong() {
        XCTAssertEqual(Location.long.coordinate, CLLocationCoordinate2D(latitude: 43.691359, longitude: -70.164709))
        XCTAssertEqual(Location.long.name, "Long Island")
        XCTAssertEqual(Location.long.description, "Mariner's Landing")
    }
    
    func testChebeague() {
        XCTAssertEqual(Location.chebeague.coordinate, CLLocationCoordinate2D(latitude: 43.715991, longitude: -70.126120))
        XCTAssertEqual(Location.chebeague.name, "Chebeague Island")
        XCTAssertEqual(Location.chebeague.description, "Chandlers Cove Landing")
    }
    
    func testCliff() {
        XCTAssertEqual(Location.cliff.coordinate, CLLocationCoordinate2D(latitude: 43.694900, longitude: -70.109666))
        XCTAssertEqual(Location.cliff.name, "Cliff Island")
        XCTAssertEqual(Location.cliff.description, "Cliff Island Landing")
    }
    
    func testBailey() {
        XCTAssertEqual(Location.bailey.coordinate, CLLocationCoordinate2D(latitude: 43.748963, longitude: -69.991044))
        XCTAssertEqual(Location.bailey.name, "Bailey Island")
        XCTAssertEqual(Location.bailey.description, "Cook's Landing")
    }
}
