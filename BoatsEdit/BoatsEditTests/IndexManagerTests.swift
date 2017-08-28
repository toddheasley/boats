//
//  BoatsEdit
//  © 2017 @toddheasley
//

import XCTest

class IndexManagerTests: XCTestCase {
    func testURL() {
        UserDefaults.standard.removeObject(forKey: "url")
        XCTAssertNil(IndexManager.url)
        IndexManager.url = URL(fileURLWithPath: "/Users/toddheasley/Boats")
        XCTAssertEqual(IndexManager.url?.absoluteString, "file:///Users/toddheasley/Boats")
        IndexManager.url = nil
        XCTAssertNil(IndexManager.url)
        UserDefaults.standard.removeObject(forKey: "url")
    }
    
    func testWeb() {
        UserDefaults.standard.removeObject(forKey: "web")
        XCTAssertFalse(IndexManager.web)
        IndexManager.web = true
        XCTAssertTrue(IndexManager.web)
        UserDefaults.standard.removeObject(forKey: "web")
    }
}
