import XCTest
@testable import BoatsKit

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
