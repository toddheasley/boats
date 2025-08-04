import Testing
@testable import Boats
import Foundation

struct URLSessionTests {
    @Test func index() async throws {
        _ = try await URLSession.shared.index(.fetch)
        _ = try await URLSession.shared.index(.build)
    }
}
