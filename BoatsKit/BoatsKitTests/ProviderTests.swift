//
// © 2018 @toddheasley
//

import XCTest
@testable import BoatsKit

class ProviderTests: XCTestCase {
    func testCodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Provider.self, from: data(for: .mock, type: "json") ?? Data())),
            let provider: Provider = try? JSON.decoder.decode(Provider.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(provider.name, "Casco Bay Lines")
        XCTAssertEqual(provider.uri, "cbl")
        XCTAssertEqual(provider.routes.count, 0)
        XCTAssertEqual(provider.url, URL(string: "https://www.cascobaylines.com"))
    }
}
