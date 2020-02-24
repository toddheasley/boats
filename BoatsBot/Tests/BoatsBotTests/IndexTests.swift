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
}

extension IndexTests {
    func testContext() {
        var index: Index = Index()
        index.current = index.routes.last
        XCTAssertEqual(Index.context["current"] as? String, "cliff-island")
        Index.context = [
            "current": "long-island"
        ]
        XCTAssertEqual(index.current?.uri, "long-island")
        Index.context = [:]
        XCTAssertNil(index.current)
    }
}

extension IndexTests {
    func testCache() {
        Index().cache()
        XCTAssertNotNil(Index(cache: 1.0))
        XCTAssertNil(Index(cache: 0.0))
    }
    
    func testCacheInit() {
        Index().cache()
        XCTAssertNotNil(Index(cache: 1.0))
        XCTAssertNil(Index(cache: 0.0))
    }
}
