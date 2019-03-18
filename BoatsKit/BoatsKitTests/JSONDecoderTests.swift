import XCTest
@testable import BoatsKit

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
        switch JSONDecoder(dateDecodingStrategy: .secondsSince1970).dateDecodingStrategy {
        case .secondsSince1970:
            break
        default:
            XCTFail()
        }
    }
}
