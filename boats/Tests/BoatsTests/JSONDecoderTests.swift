import XCTest
@testable import Boats

class JSONDecoderTests: XCTestCase {
    
}

extension JSONDecoderTests {
    func testShared() {
        switch JSONDecoder.shared.dateDecodingStrategy {
        case .secondsSince1970:
            break
        default:
            XCTFail()
        }
    }
    
    func testDateEncodingStrategyInit() {
        switch JSONDecoder(.secondsSince1970).dateDecodingStrategy {
        case .secondsSince1970:
            break
        default:
            XCTFail()
        }
    }
}
