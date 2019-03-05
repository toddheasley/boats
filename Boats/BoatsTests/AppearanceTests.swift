import XCTest

class AppearanceTests: XCTestCase {
    func testShared() {
        Appearance.shared = .auto
        XCTAssertEqual(Appearance.shared, .auto)
        Appearance.shared = .light
        XCTAssertEqual(Appearance.shared, .light)
        Appearance.shared = .dark
        XCTAssertEqual(Appearance.shared, .dark)
        UserDefaults.standard.removeObject(forKey: "appearance")
        XCTAssertEqual(Appearance.shared, .auto)
    }
}
