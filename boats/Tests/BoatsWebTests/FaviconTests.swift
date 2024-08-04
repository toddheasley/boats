import Testing
@testable import BoatsWeb

struct FaviconTests {
    
    // MARK: Resource
    @Test func path() {
        #expect(Favicon().path == "favicon.ico")
    }
    
    @Test func data() throws {
        #expect(try Favicon().data().count == 1494)
    }
}
