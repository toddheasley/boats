//
// © 2018 @toddheasley
//

import XCTest
@testable import BoatsKit

class CoordinateTests: XCTestCase {
    func testCoordinate() {
        XCTAssertEqual(Coordinate(0.0, 0.0).latitude, 0.0)
        XCTAssertEqual(Coordinate(0.0, 0.0).longitude, 0.0)
        XCTAssertEqual(Coordinate(-90.0, 0.0).latitude, -85.0)
        XCTAssertEqual(Coordinate(90.0, 0.0).latitude, 85.0)
        XCTAssertEqual(Coordinate(0.0, -181.571390).longitude, -180.0)
        XCTAssertEqual(Coordinate(0.0, 180.000512).longitude, 180.0)
    }
}
