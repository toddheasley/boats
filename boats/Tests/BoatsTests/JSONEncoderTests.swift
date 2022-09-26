import XCTest
@testable import Boats

class JSONEncoderTests: XCTestCase {
    
}

extension JSONEncoderTests {
    func testShared() {
        switch JSONEncoder.shared.dateEncodingStrategy {
        case .secondsSince1970:
            break
        default:
            XCTFail()
        }
    }
    
    func testDateEncodingStrategyInit() {
        switch JSONEncoder(.secondsSince1970).dateEncodingStrategy {
        case .secondsSince1970:
            break
        default:
            XCTFail()
        }
    }
}
