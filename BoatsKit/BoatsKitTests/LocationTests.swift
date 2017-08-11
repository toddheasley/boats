//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class LocationTests: XCTestCase {
    func testCodable() {
        guard let data: Data = try? JSONEncoder().encode(try? JSONDecoder().decode(Location.self, from: data ?? Data())),
            let location: Location = try? JSONDecoder().decode(Location.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(location.name, "Peaks Island")
        XCTAssertEqual(location.description, "Forest City Landing")
        XCTAssertEqual(location.coordinate.latitude, 43.661719)
        XCTAssertEqual(location.coordinate.longitude, -70.1960907)
    }
}
