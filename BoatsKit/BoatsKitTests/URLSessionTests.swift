import XCTest
@testable import BoatsKit

class URLSessionTests: XCTestCase {
    
}

extension URLSessionTests {
    func testIndex() {
        let expectations: [XCTestExpectation] = [
            expectation(description: "fetch"),
            expectation(description: "build")
        ]
        URLSession.shared.index(action: .fetch) { index, error in
            expectations[0].fulfill()
        }
        URLSession.shared.index(action: .build) { index, error in
            expectations[1].fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testFetch() {
        let expectation: XCTestExpectation = self.expectation(description: "fetch")
        URLSession.shared.fetch { index, error in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testBuild() {
        let expectation: XCTestExpectation = self.expectation(description: "build")
        URLSession.shared.build { index, error in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
