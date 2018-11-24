import XCTest
@testable import BoatsWeb

class ScriptTests: XCTestCase {
    
}

extension ScriptTests {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(Script().path, "script.js")
    }
    
    func testData() {
        XCTAssertNoThrow(try Script().data())
    }
}
