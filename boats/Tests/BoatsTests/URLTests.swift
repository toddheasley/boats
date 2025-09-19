import Testing
@testable import Boats
import Foundation

struct URLTests {
    @Test func directoryInit() throws {
        #expect(throws: Error.self) {
            try URL(directory: "\(NSTemporaryDirectory())test/")
        }
        #expect(throws: Error.self) {
            try URL(directory: "\(NSTemporaryDirectory())test.txt")
        }
        _ = try URL(directory: NSTemporaryDirectory())
    }
    
    @Test func delete() throws {
        let url: URL = try URL(directory: NSTemporaryDirectory()).appendingPathComponent("test.txt")
        try Data().write(to: url)
        #expect(FileManager.default.fileExists(atPath: url.path))
        try url.delete()
        #expect(!FileManager.default.fileExists(atPath: url.path))
        try url.delete()
    }
    
    @Test func debug() {
        #expect(URL.debug("https://s3.amazonaws.com/boats/index.json")?.absoluteString == "https://s3.amazonaws.com/boats/index.json")
        #expect(URL.debug("https://s3.amazonaws.com/boats/")?.absoluteString == "https://s3.amazonaws.com/boats/index.json")
        #expect(URL.debug("https://s3.amazonaws.com/boats")?.absoluteString == "https://s3.amazonaws.com/boats/index.json")
        #expect(URL.debug("file:///Users/toddheasley/Documents/Boats/boats-web")?.absoluteString == "file:///Users/toddheasley/Documents/Boats/boats-web/index.json")
        #expect(URL.debug("/Users/toddheasley/Documents/Boats/boats-web")?.absoluteString == "file:///Users/toddheasley/Documents/Boats/boats-web/index.json")
    }
    
    @Test func schedule() {
        #expect(URL.schedule(for: .peaks, season: .spring) == URL(string: "https://www.cascobaylines.com/schedules/peaks-island-schedule/spring"))
        #expect(URL.schedule(for: .littleDiamond, season: .summer) == URL(string: "https://www.cascobaylines.com/schedules/little-diamond-island-schedule/summer"))
        #expect(URL.schedule(for: .greatDiamond, season: .fall) == URL(string: "https://www.cascobaylines.com/schedules/great-diamond-schedule/fall"))
        #expect(URL.schedule(for: .diamondCove, season: .winter) == URL(string: "https://www.cascobaylines.com/schedules/diamond-cove-schedule/winter"))
    }
}
