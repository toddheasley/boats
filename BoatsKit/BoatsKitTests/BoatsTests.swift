//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest
@testable import BoatsKit

class BoatsTests: XCTestCase {
    
}

extension BoatsTests {
    func testData() {
        guard let data = data,
            let boats = Boats(data: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(boats.name, "Ferry Schedules")
        XCTAssertEqual(Boats(data: boats.data)?.name, boats.name)
        XCTAssertEqual(boats.description, "Islands of Casco Bay")
        XCTAssertEqual(Boats(data: boats.data)?.description, boats.description)
        XCTAssertEqual(boats.providers.count, 0)
        XCTAssertEqual(Boats(data: boats.data)?.providers.count, boats.providers.count)
        XCTAssertEqual(boats.timeZone, TimeZone(identifier: "America/New_York"))
        XCTAssertEqual(Boats(data: boats.data)?.timeZone, boats.timeZone)
    }
}

extension BoatsTests {
    func testRead() {
        
    }
    
    func testWrite() {
        
    }
}
