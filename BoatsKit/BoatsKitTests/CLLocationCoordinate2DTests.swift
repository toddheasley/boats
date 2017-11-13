//
// © 2017 @toddheasley
//

import XCTest
import CoreLocation
@testable import BoatsKit

class CLLocationCoordinate2DTests: XCTestCase {
    
}

extension CLLocationCoordinate2DTests {
    func testCodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(CLLocationCoordinate2D.self, from: data(for: .mock, type: "json") ?? Data())),
            let coordinate: CLLocationCoordinate2D = try? JSON.decoder.decode(CLLocationCoordinate2D.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(coordinate.latitude, 43.661719)
        XCTAssertEqual(coordinate.longitude, -70.1960907)
    }
}
