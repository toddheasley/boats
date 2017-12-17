import XCTest
@testable import BoatsKit

class LocalizationTests: XCTestCase {
    func testCodable() {
        guard let data: Data = try? JSON.encoder.encode(try? JSON.decoder.decode(Localization.self, from: data(for: .mock, type: "json") ?? Data())),
            let localization: Localization = try? JSON.decoder.decode(Localization.self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(localization.timeZone, TimeZone(identifier: "America/New_York"))
        XCTAssertEqual(localization.locale, Locale(identifier: "en_CA"))
    }
}
