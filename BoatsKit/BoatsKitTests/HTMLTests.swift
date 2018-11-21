import XCTest
@testable import BoatsKit

class HTMLTests: XCTestCase {
    func testError() {
        XCTAssertEqual(HTML.error(Time.self, from: "<td>16:20 cf</td>"), NSError(domain: HTMLErrorDomain, code: HTMLConvertibleError, userInfo: ["type": "Time", "html": "<td>16:20 cf</td>"]))
    }
}
