import Testing
@testable import BoatsWeb

struct BookmarkIconTests {
    
    // MARK: Resource
    @Test func path() {
        #expect(BookmarkIcon().path == "apple-touch-icon.png")
    }
    
    @Test func data() throws {
        #expect(try BookmarkIcon().data().count == 3638)
    }
}
