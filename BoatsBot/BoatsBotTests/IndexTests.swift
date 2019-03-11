import XCTest
import BoatsKit
@testable import BoatsBot

class IndexTests: XCTestCase {
    
}

extension IndexTests {
    func testRoute() {
        var index: Index = Index()
        index.current = .chebeague
        XCTAssertNotNil(index.route)
        XCTAssertEqual(index.route, .chebeague)
        index.current = nil
        XCTAssertNotNil(index.route)
        XCTAssertEqual(index.route, index.routes.first)
    }
    
    func testCurrent() {
        var index: Index = Index()
        index.current = index.routes.last
        XCTAssertEqual(index.current?.uri, "cliff-island")
        index.current = nil
        XCTAssertNil(index.current)
    }
    
    func testContext() {
        let index: Index = Index()
        Index.context = [
            "current": "long-island".data(using: .utf8) as Any
        ]
        XCTAssertEqual(index.current?.uri, "long-island")
        XCTAssertEqual(Index.context["current"] as? Data, "long-island".data(using: .utf8))
        XCTAssertEqual(Index.context.count, 1)
        Index.context = [:]
        XCTAssertNil(index.current)
        XCTAssertNil(Index.context["current"])
        XCTAssertTrue(Index.context.isEmpty)
    }
}
