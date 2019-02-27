import XCTest
@testable import BoatsKit

class IndexTests: XCTestCase {
    func testRoute() {
        XCTAssertEqual(Index().route(uri: "peaks-island"), Index().routes.first)
        XCTAssertEqual(Index().route(uri: "cliff-island"), Index().routes.last)
        XCTAssertNil(Index().route(uri: "catalina-island"))
    }
    
    func testRoutesInit() {
        XCTAssertEqual(Index().name, "Casco Bay Lines")
        XCTAssertEqual(Index().description, "Ferry Schedules")
        XCTAssertEqual(Index().url, URL(string: "https://www.cascobaylines.com"))
        XCTAssertEqual(Index().location, .portland)
        XCTAssertEqual(Index(routes: [.bailey]).routes, [.bailey])
        XCTAssertEqual(Index().routes, Route.allCases)
        XCTAssertEqual(Index().uri, "index")
    }
}

extension IndexTests {
    func testURLInit() {
        guard let url: URL = try? URL(directory: NSTemporaryDirectory()) else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try Index().build(to: url))
        XCTAssertNoThrow(try Index(from: url))
    }
    
    func testDataInit() {
        guard let data: Data = try? Index().data() else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try Index(data: data))
    }
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(Index().path, "index.json")
    }
    
    func testData() {
        XCTAssertNoThrow(try Index().data())
    }
}
