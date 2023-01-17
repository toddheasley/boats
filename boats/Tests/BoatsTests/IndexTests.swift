import XCTest
@testable import Boats

class IndexTests: XCTestCase {
    func testRoutesInit() {
        XCTAssertEqual(Index().name, "Casco Bay Lines")
        XCTAssertEqual(Index().description, "Ferry Schedules")
        XCTAssertEqual(Index().uri, "index")
        XCTAssertEqual(Index().location, .portland)
        XCTAssertEqual(Index(routes: [.bailey]).routes, [.bailey])
        XCTAssertEqual(Index().routes, Route.allCases)
        XCTAssertEqual(Index().url, URL(string: "https://www.cascobaylines.com"))
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
