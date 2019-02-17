import XCTest
import BoatsKit
@testable import BoatsBot

class UserDefaultsTests: XCTestCase {
    
}

extension UserDefaultsTests {
    func testSetData() {
        UserDefaults.standard.removeObject(forKey: "test")
        XCTAssertNil(UserDefaults.standard.data(forKey: "test"))
        UserDefaults.standard.set(data: "peaks-island".data(using: .utf8), for: Key.test)
        XCTAssertEqual(String(data: UserDefaults.standard.data(forKey: "test") ?? Data(), encoding: .utf8), "peaks-island")
        UserDefaults.standard.set(data: nil, for: Key.test)
        XCTAssertNil(UserDefaults.standard.data(forKey: "test"))
    }
    
    func testData() {
        UserDefaults.standard.set("cliff-island".data(using: .utf8), forKey: "test")
        XCTAssertEqual(String(data: UserDefaults.standard.data(for: Key.test) ?? Data(), encoding: .utf8), "cliff-island")
        UserDefaults.standard.set(nil, forKey: "test")
        XCTAssertNil(UserDefaults.standard.data(for: Key.test))
    }
    
    private enum Key: CodingKey {
        case test
    }
}
