import XCTest
@testable import BoatsKit

class HTMLTests: XCTestCase {
    func testError() {
        XCTAssertEqual(HTML.error(Time.self, from: ""), NSError(domain: HTMLErrorDomain, code: HTMLConvertibleError))
    }
}
