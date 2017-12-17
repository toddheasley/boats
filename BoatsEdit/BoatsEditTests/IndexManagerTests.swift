import XCTest
import BoatsKit
import BoatsWeb

class IndexManagerTests: XCTestCase {
    private let url: URL = URL(fileURLWithPath: NSTemporaryDirectory())
    
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
        IndexManager.url = nil
        XCTAssertFalse(IndexManager.web)
        XCTAssertNoThrow(try IndexManager.make(at: url))
        XCTAssertNotNil(IndexManager.url)
        XCTAssertNotNil(IndexManager.index)
        XCTAssertFalse(IndexManager.web)
        IndexManager.web = true
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.appending(uri: Site.uri).path))
        XCTAssertTrue(IndexManager.web)
        IndexManager.web = false
        XCTAssertFalse(FileManager.default.fileExists(atPath: url.appending(uri: Site.uri).path))
        XCTAssertFalse(IndexManager.web)
        IndexManager.url = nil
    }
    
    func testCanOpen() {
        try? FileManager.default.removeItem(at: url.appending(uri: Index().uri))
        XCTAssertFalse(IndexManager.canOpen(from: url.appending(uri: Index().uri)))
        XCTAssertNoThrow(try IndexManager.make(at: url))
        XCTAssertTrue(IndexManager.canOpen(from: url.appending(uri: Index().uri)))
        XCTAssertFalse(IndexManager.canOpen(from: url.appendingPathComponent("index.html")))
        XCTAssertFalse(IndexManager.canOpen(from: url))
    }
    
    func testOpen() {
        XCTAssertNoThrow(try IndexManager.make(at: url))
        XCTAssertNoThrow(try IndexManager.open())
        XCTAssertNotNil(IndexManager.index)
        IndexManager.url = nil
        XCTAssertNoThrow(try IndexManager.open())
        XCTAssertNil(IndexManager.index)
        XCTAssertNoThrow(try IndexManager.open(from: url))
        XCTAssertEqual(IndexManager.url, url)
        XCTAssertNotNil(IndexManager.index)
    }
    
    func testMake() {
        
        NSWorkspace.shared.open(url)
        
        try? FileManager.default.removeItem(at: url.appending(uri: Index().uri))
        XCTAssertNoThrow(try IndexManager.make(at: url))
        XCTAssertNotNil(IndexManager.index)
        XCTAssertEqual(IndexManager.url, url)
        XCTAssertNoThrow(try IndexManager.make(at: url))
        XCTAssertNotNil(IndexManager.index)
        XCTAssertEqual(IndexManager.url, url)
    }
    
    func testSave() {
        try? FileManager.default.removeItem(at: url.appending(uri: Index().uri))
        XCTAssertThrowsError(try IndexManager.save(index: nil))
        XCTAssertNoThrow(try IndexManager.make(at: url))
        XCTAssertNoThrow(try IndexManager.save(index: IndexManager.index))
    }
    
    override func tearDown() {
        IndexManager.url = nil
        UserDefaults.standard.removeObject(forKey: "url")
        try? FileManager.default.removeItem(at: url.appending(uri: Index().uri))
        super.tearDown()
    }
}
