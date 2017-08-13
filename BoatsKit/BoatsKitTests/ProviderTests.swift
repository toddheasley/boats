//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class ProviderTests: XCTestCase {
    func testCodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Provider.self, from: data ?? Data())),
            let provider: Provider = try? JSON.decoder.decode(Provider.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(provider.name, "Casco Bay Lines")
        XCTAssertEqual(provider.routes.count, 0)
        XCTAssertEqual(provider.url, URL(string: "https://www.cascobaylines.com"))
    }
}
