import XCTest
@testable import BoatsEdit

class UserDefaultsTests: XCTestCase {
    func testWeb() {
        UserDefaults.standard.set(true, forKey: "com.toddheasley.boats.edit.web")
        XCTAssertEqual(UserDefaults.standard.web, .on)
        UserDefaults.standard.web = .mixed
        XCTAssertEqual(UserDefaults.standard.web, .off)
        UserDefaults.standard.web = .on
        XCTAssertEqual(UserDefaults.standard.web, .on)
        UserDefaults.standard.web = .off
        XCTAssertEqual(UserDefaults.standard.web, .off)
        UserDefaults.standard.removeObject(forKey: "com.toddheasley.boats.edit.web")
    }
}