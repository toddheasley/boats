import Testing
@testable import Boats
import CoreLocation

struct LocationTests {
    @Test func nickname() {
        #expect(Location.portland.nickname == "Portland")
        #expect(Location.peaks.nickname == "Peaks")
        #expect(Location.diamondCove.nickname == "Diamond Cove")
        #expect(Location.chebeague.nickname == "Chebeague")
    }
}

extension LocationTests {
    
    // MARK: Equatable
    @Test func equal() {
        #expect(Location.peaks != .portland)
        #expect(Location.peaks == .peaks)
    }
}

extension LocationTests {
    
    // MARK: CaseIterable
    @Test func allCases() {
        #expect(Location.allCases == [.portland, .peaks, .littleDiamond, .greatDiamond, .diamondCove, .long, .chebeague, .cliff, .bailey])
    }
}
