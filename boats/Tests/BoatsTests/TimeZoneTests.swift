import Testing
@testable import Boats
import Foundation

struct TimeZoneTests {
    @Test func shared() {
        #expect(TimeZone.shared.identifier == "America/New_York")
    }
}
