import XCTest
@testable import BoatsKit

class URLTests: XCTestCase {
    
}

extension URLTests {
    func testDirectoryInit() {
        XCTAssertThrowsError(try URL(directory: "\(NSTemporaryDirectory())test/"))
        XCTAssertThrowsError(try URL(directory: "\(NSTemporaryDirectory())test.txt"))
        XCTAssertNoThrow(try URL(directory: NSTemporaryDirectory()))
    }
    
    func testDelete() {
        guard let url: URL = (try? URL(directory: NSTemporaryDirectory()))?.appendingPathComponent("test.txt") else {
            XCTFail()
            return
        }
        try? Data().write(to: url)
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
        XCTAssertNoThrow(try url.delete())
        XCTAssertFalse(FileManager.default.fileExists(atPath: url.path))
        XCTAssertNoThrow(try url.delete())
    }
}

extension URLTests {
    func testSchedule() {
        XCTAssertEqual(URL.schedule(for: .peaks, season: .spring), URL(string: "https://www.cascobaylines.com/schedules/peaks-island-schedule/spring"))
        XCTAssertEqual(URL.schedule(for: .littleDiamond, season: .summer), URL(string: "https://www.cascobaylines.com/schedules/little-diamond-island-schedule/summer"))
        XCTAssertEqual(URL.schedule(for: .greatDiamond, season: .fall), URL(string: "https://www.cascobaylines.com/schedules/great-diamond-schedule/fall"))
        XCTAssertEqual(URL.schedule(for: .diamondCove, season: .winter), URL(string: "https://www.cascobaylines.com/schedules/diamond-cove-schedule/winter"))
    }
}
