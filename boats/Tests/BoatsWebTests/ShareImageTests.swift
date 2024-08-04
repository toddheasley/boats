import Testing
@testable import BoatsWeb

struct ShareImageTests {
    
    // MARK: Resource
    @Test func path() {
        #expect(ShareImage().path == "share-image.png")
    }
    
    @Test func data() throws {
        #expect(try ShareImage().data().count == 22878)
    }
}
