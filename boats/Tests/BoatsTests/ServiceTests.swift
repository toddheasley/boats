import XCTest
@testable import Boats

class ServiceTests: XCTestCase {
    
}

extension ServiceTests {
    
    // MARK: StringConvertible
    func testDescription() {
        for service in Service.allCases {
            XCTAssertEqual(service.description, "\(service.rawValue)")
        }
    }
}
