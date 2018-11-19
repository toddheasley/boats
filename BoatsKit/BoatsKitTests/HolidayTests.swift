import XCTest
@testable import BoatsKit

class HolidayTests: XCTestCase {
    
}

extension HolidayTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Holiday.independence.description, "Independence Day: Jul 4")
        XCTAssertEqual(Holiday.christmas.description, "Christmas Day: Dec 25")
        XCTAssertEqual(Holiday.newYears.description, "New Year's Day: Jan 1")
    }
}

extension HolidayTests {
    
    // MARK: Equatable
    func testEqual() {
        XCTAssertNotEqual(Holiday.newYears, .christmas)
        XCTAssertEqual(Holiday.memorial, .memorial)
    }
}

extension HolidayTests {
    
    // MARK: CaseIterable
    func testAllCases() {
        XCTAssertEqual(Holiday.allCases, [Holiday.memorial, .independence, .labor, .columbus, .veterans, .thanksgiving, .christmas, .newYears])
    }
}

extension HolidayTests {
    func testMemorial() {
        XCTAssertEqual(Holiday.memorial.name, "Memorial Day")
    }
    
    func testIndependence() {
        XCTAssertEqual(Holiday.independence.name, "Independence Day")
        XCTAssertEqual(Holiday.independence.date, DateFormatter.shared.next(month: 7, day: 4))
    }
    
    func testLabor() {
        XCTAssertEqual(Holiday.labor.name, "Labor Day")
    }
    
    func testColumbus() {
        XCTAssertEqual(Holiday.columbus.name, "Columbus Day")
    }
    
    func testVeterans() {
        XCTAssertEqual(Holiday.veterans.name, "Veterans Day")
        XCTAssertEqual(Holiday.veterans.date, DateFormatter.shared.next(month: 11, day: 11))
    }
    
    func testThanksgiving() {
        XCTAssertEqual(Holiday.thanksgiving.name, "Thanksgiving")
    }
    
    func testChristmas() {
        XCTAssertEqual(Holiday.christmas.name, "Christmas Day")
        XCTAssertEqual(Holiday.christmas.date, DateFormatter.shared.next(month: 12, day: 25))
    }
    
    func testNewYears() {
        XCTAssertEqual(Holiday.newYears.name, "New Year's Day")
        XCTAssertEqual(Holiday.newYears.date, DateFormatter.shared.next(month: 1, day: 1))
    }
}
