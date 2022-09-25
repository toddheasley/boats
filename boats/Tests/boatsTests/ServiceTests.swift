import XCTest
@testable import Boats

class ServiceTests: XCTestCase {
    
}

extension ServiceTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        for service in Service.allCases {
            XCTAssertEqual(service.description, "\(service.rawValue)")
        }
    }
}
