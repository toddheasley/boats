import XCTest
import BoatsKit
@testable import BoatsBot

class IndexTests: XCTestCase {
    
}

extension IndexTests {
    func testPrimary() {
        var index: Index = Index()
        index.primary = index.routes.first
        XCTAssertEqual(index.primary?.uri, "peaks-island")
        index.primary = nil
        XCTAssertNil(index.primary)
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
            "primary": "chebeague-island".data(using: .utf8) as Any,
            "current": "long-island".data(using: .utf8) as Any
        ]
        XCTAssertEqual(index.primary?.uri, "chebeague-island")
        XCTAssertEqual(index.current?.uri, "long-island")
        XCTAssertEqual(Index.context["primary"] as? Data, "chebeague-island".data(using: .utf8))
        XCTAssertEqual(Index.context["current"] as? Data, "long-island".data(using: .utf8))
        XCTAssertEqual(Index.context.count, 2)
        Index.context = [
            "primary": "chebeague-island".data(using: .utf8) as Any
        ]
        XCTAssertEqual(index.primary?.uri, "chebeague-island")
        XCTAssertNil(index.current)
        
        XCTAssertEqual(Index.context["primary"] as? Data, "chebeague-island".data(using: .utf8))
        XCTAssertNil(Index.context["current"])
        XCTAssertEqual(Index.context.count, 1)
        Index.context = [
            "current": "long-island".data(using: .utf8) as Any
        ]
        XCTAssertEqual(index.current?.uri, "long-island")
        XCTAssertNil(index.primary)
        XCTAssertEqual(Index.context["current"] as? Data, "long-island".data(using: .utf8))
        XCTAssertNil(Index.context["primary"])
        XCTAssertEqual(Index.context.count, 1)
        Index.context = [:]
        XCTAssertNil(index.primary)
        XCTAssertNil(index.current)
        XCTAssertTrue(Index.context.isEmpty)
    }
}
