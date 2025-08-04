import Testing
@testable import Boats
import Foundation

struct IndexTests {
    @Test func routesInit() {
        #expect(Index().name == "Casco Bay Lines")
        #expect(Index().description == "Ferry Schedules")
        #expect(Index().uri == "index")
        #expect(Index().location == .portland)
        #expect(Index(routes: [.bailey]).routes == [.bailey])
        #expect(Index().routes == Route.allCases)
        #expect(Index().url == URL(string: "https://www.cascobaylines.com"))
    }
}

extension IndexTests {
    @Test func urlInit() throws {
        let url: URL = try URL(directory: NSTemporaryDirectory())
        try Index().build(to: url)
        _ = try Index(from: url)
    }
    
    @Test func dataInit() throws {
        let data: Data = try Index().data()
        _ = try Index(data: data)
    }
    
    // MARK: Resource
    @Test func path() {
        #expect(Index().path == "index.json")
    }
    
    @Test func data() throws {
        _ = try Index().data()
    }
}
