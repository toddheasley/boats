import XCTest
@testable import BoatsKit

class URLSessionTests: XCTestCase {
    
}

extension URLSessionTests {
    func testActionAllCases() {
        XCTAssertEqual(URLSession.Action.allCases, [.fetch, .build, .debug(.fetch)])
    }
    
    func testActionRawValue() {
        XCTAssertEqual(URLSession.Action(rawValue: "fetch"), .fetch)
        XCTAssertEqual(URLSession.Action(rawValue: "build"), .build)
        XCTAssertEqual(URLSession.Action(rawValue: "debug file:///Documents/Boats/boats-web"), .debug(URL(fileURLWithPath: "/Documents/Boats/boats-web/index.json")))
    }
    
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
            XCTAssertNotNil(index)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testBuild() {
        let expectation: XCTestExpectation = self.expectation(description: "build")
        URLSession.shared.build { index, error in
            for route in index!.routes {
                XCTAssertFalse(route.schedules.isEmpty)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testRoutesBuild() {
        let expectation: XCTestExpectation = self.expectation(description: "build")
        URLSession.shared.build(routes: [], from: 0) { routes, _ in
            for route in routes {
                XCTAssertFalse(route.schedules.isEmpty)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testRouteBuild() {
        let expectation: XCTestExpectation = self.expectation(description: "build")
        URLSession.shared.build(route: .peaks) { route, errors in
            XCTAssertFalse(route.schedules.isEmpty)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testScheduleBuild() {
        let expectations: [XCTestExpectation] = [
            expectation(description: "peaks"),
            expectation(description: "cliff")
        ]
        URLSession.shared.build(schedule: .schedule(for: .peaks, season: .spring)) { schedule, error in
            XCTAssertNotNil(schedule)
            expectations[0].fulfill()
        }
        URLSession.shared.build(schedule: .schedule(for: .cliff, season: .summer)) { schedule, error in
            XCTAssertNotNil(schedule)
            expectations[1].fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testDebug() {
        let expectation: XCTestExpectation = self.expectation(description: "debug")
        URLSession.shared.debug(url: .fetch) { index, error in
            XCTAssertNotNil(index)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
