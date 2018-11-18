import XCTest
@testable import BoatsKit

class HolidayTests: XCTestCase {
    
}

extension HolidayTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        
    }
}

extension HolidayTests {
    func testMemorial() {
        
    }
    
    func testIndependence() {
        
    }
    
    func testLabor() {
        
    }
    
    func testColumbus() {
        
    }
    
    func testVeterans() {
        
    }
    
    func testThanksgiving() {
        
    }
    
    func testChristmas() {
        XCTAssertEqual(Holiday.christmas.name, "Christmas Day")
        XCTAssertEqual(Holiday.christmas.date, Date(timeIntervalSince1970: 1545714000.0))
    }
    
    func testNewYears() {
        
    }
}
