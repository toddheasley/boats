//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
import CoreLocation
@testable import BoatsKit

class CLLocationCoordinate2DTests: XCTestCase {
    func testCodable() {
        guard let data: Data = try? JSONEncoder().encode(try? JSONDecoder().decode(CLLocationCoordinate2D.self, from: data ?? Data())),
            let coordinate: CLLocationCoordinate2D = try? JSONDecoder().decode(CLLocationCoordinate2D.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(coordinate.latitude, 43.661719)
        XCTAssertEqual(coordinate.longitude, -70.1960907)
    }
}
