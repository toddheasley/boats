import XCTest
@testable import BoatsWeb

class SVGTests: XCTestCase {
    
}

extension SVGTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(SVG.menu.description, "menu")
        XCTAssertEqual(SVG.car.description, "car")
    }
}

extension SVGTests {
    
    // MARK: Resource
    func testPath() {
        XCTAssertEqual(SVG.menu.path, "menu.svg")
        XCTAssertEqual(SVG.car.path, "car.svg")
    }
    
    func testData() {
        XCTAssertNoThrow(try SVG.menu.data())
        XCTAssertNoThrow(try SVG.car.data())
    }
}

extension SVGTests {
    
    // MARK: HTMLConvertible
    func testHTML() {
        XCTAssertNoThrow(try SVG.menu.html())
        XCTAssertNoThrow(try SVG.car.html())
    }
}
