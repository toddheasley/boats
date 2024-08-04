import Testing
@testable import Boats

struct StringTests {
    @Test func find() {
        #expect("<p style=\"text-align: center;\"><span style=\"font-size: large;\"><strong>Currently Displaying:</strong> Winter Schedule </span><br />".find("<span[^>]*>(.*?)</span>").first == "<strong>Currently Displaying:</strong> Winter Schedule ")
    }
    
    @Test func stripHTML() {
        #expect("<p style=\"text-align: center;\"><span style=\"font-size: large;\"><strong>Currently Displaying:</strong> Winter Schedule </span><br />".stripHTML() == "Currently Displaying: Winter Schedule ")
    }
    
    @Test func trim() {
        #expect(" \n".trim() == "")
        #expect(" Portland's Iconic Ferry\nServicing the Islands of Casco Bay\n".trim() == "Portland's Iconic Ferry\nServicing the Islands of Casco Bay")
        #expect("".trim() == "")
    }
}
