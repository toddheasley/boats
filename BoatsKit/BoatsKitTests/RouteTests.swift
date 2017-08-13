//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class RouteTests: XCTestCase {
    func testDecodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Route.self, from: data ?? Data())),
            let route: Route = try? JSON.decoder.decode(Route.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(route.name, "Peaks Island")
        XCTAssertEqual(route.destination.name, "Peaks Island")
        XCTAssertEqual(route.origin.name, "Portland")
        XCTAssertEqual(route.services.count, 2)
        XCTAssertEqual(route.schedules.count, 1)
    }
    
    func testSchedule() {
        guard let route: Route = try? JSON.decoder.decode(Route.self, from: data ?? Data()) else {
            XCTFail()
            return
        }
        XCTAssertNotNil(route.schedule(for: Date(timeIntervalSince1970: 1498881601.0)))
        XCTAssertNotNil(route.schedule(for: Date(timeIntervalSince1970: 1501473599.0)))
        XCTAssertNil(route.schedule(for: Date(timeIntervalSince1970: 1498881599.0)))
        XCTAssertNil(route.schedule(for: Date(timeIntervalSince1970: 1501473601.0)))
    }
}
