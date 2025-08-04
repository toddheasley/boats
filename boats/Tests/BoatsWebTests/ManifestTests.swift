import Testing
@testable import BoatsWeb
import Boats
import Foundation

struct ManifestTests {
    @Test func urlInit() throws {
        let url: URL = try URL(directory: NSTemporaryDirectory()).appendingPathComponent(Manifest().path)
        try Manifest_Data.write(to: url)
        _ = try Manifest(url: try URL(directory: NSTemporaryDirectory()))
    }
    
    @Test func dataInit() throws {
        _ = try Manifest(data: Manifest_Data)
        #expect(try Manifest(data: Manifest_Data).paths == ["favicon.png", "script.js", "index.html", "stylesheet.css"])
    }
    
    // MARK: Resource
    @Test func path() {
        #expect(Manifest().path == "manifest.appcache")
    }
    
    @Test func data() throws {
        #expect(try Manifest(data: Manifest_Data).data().count > 0)
        #expect(try Manifest().data().count == 15)
    }
}

private let Manifest_Data: Data = """
CACHE MANIFEST
favicon.png
stylesheet.css
script.js
index.html
""".data(using: .utf8)!
