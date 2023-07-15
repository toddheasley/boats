import XCTest
@testable import BoatsWeb

class ColorTests: XCTestCase {
    func testName() {
        XCTAssertEqual(Color(255).name, "white")
        XCTAssertNil(Color(201, 223, 238).name)
        XCTAssertNil(Color(204, alpha: 0.25).name)
    }
    
    func testRGBInit() {
        XCTAssertEqual(Color(-23, 487, 77, alpha: 0.9).red, 0)
        XCTAssertEqual(Color(-23, 487, 77, alpha: 0.9).green, 255)
        XCTAssertEqual(Color(-23, 487, 77, alpha: 0.9).blue, 77)
        XCTAssertEqual(Color(-23, 487, 77, alpha: 0.9).alpha, 0.9)
        XCTAssertEqual(Color(-23, 487, 77, alpha: 0.9).alpha, 0.9)
        XCTAssertEqual(Color(-23, 487, 77, alpha: 100).alpha, 1.0)
        XCTAssertEqual(Color(-23, 487, 77, alpha: -1).alpha, 0.0)
        XCTAssertEqual(Color(201, 223, 238).red, 201)
        XCTAssertEqual(Color(201, 223, 238).green, 223)
        XCTAssertEqual(Color(201, 223, 238).blue, 238)
        XCTAssertEqual(Color(201, 223, 238).alpha, 1.0)
    }
    
    func testWhiteInit() {
        XCTAssertEqual(Color(204, alpha: 0.25).red, 204)
        XCTAssertEqual(Color(204, alpha: 0.25).green, 204)
        XCTAssertEqual(Color(204, alpha: 0.25).blue, 204)
        XCTAssertEqual(Color(204, alpha: 0.25).alpha, 0.25)
    }
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Color.aqua.description, "rgb(201, 223, 238)")
        XCTAssertEqual(Color.gold.description, "rgb(241, 185, 77)")
        XCTAssertEqual(Color.haze.description, "rgba(204, 204, 204, 0.25)")
        XCTAssertEqual(Color.link.description, "rgb(44, 103, 212)")
        XCTAssertEqual(Color.navy.description, "rgb(32, 61, 83)")
    }
}

extension ColorTests {
    
    // MARK: CaseIterable
    func testAllCases() {
        XCTAssertEqual(Color.allCases, [.aqua, .gold, .haze, .link, .navy])
    }
}
