import XCTest
@testable import BoatsKit

class TimetableTests: XCTestCase {
    
}

extension TimetableTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Timetable(trips: [], days: [.monday, .tuesday, .wednesday, .thursday]).description, "Monday, Tuesday, Wednesday, Thursday")
        XCTAssertEqual(Timetable(trips: [], days: [.friday, .saturday]).description, "Friday, Saturday")
        XCTAssertEqual(Timetable(trips: [], days: [.sunday, .holiday]).description, "Sunday, Holiday")
    }
}

extension TimetableTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() {
        guard let data: Data = data(resource: .bundle, type: "html"),
            let html: [String] = String(data: data, encoding: .utf8)?.find("<table[^>]*>(.*?)</table>"), html.count == 4 else {
            XCTFail()
            return
        }
        XCTAssertEqual(try? Timetable(from: "\(html[0])").trips.count, 14)
        XCTAssertEqual(try? Timetable(from: "\(html[0])").trips.first?.origin?.time, Time(hour: 5, minute: 45))
        XCTAssertEqual(try? Timetable(from: "\(html[0])").trips.last?.destination?.time, Time(hour: 22, minute: 55))
        XCTAssertEqual(try? Timetable(from: "\(html[0])").days, [.monday, .tuesday, .wednesday, .thursday])
        XCTAssertEqual(try? Timetable(from: "\(html[1])").trips.count, 15)
        XCTAssertEqual(try? Timetable(from: "\(html[1])").trips.first?.origin?.time, Time(hour: 5, minute: 45))
        XCTAssertEqual(try? Timetable(from: "\(html[1])").trips.last?.destination?.time, Time(hour: 23, minute: 55))
        XCTAssertEqual(try? Timetable(from: "\(html[1])").days, [.friday])
        XCTAssertEqual(try? Timetable(from: "\(html[2])").trips.count, 15)
        XCTAssertEqual(try? Timetable(from: "\(html[2])").trips.first?.origin?.time, Time(hour: 5, minute: 45))
        XCTAssertEqual(try? Timetable(from: "\(html[2])").trips.last?.destination?.time, Time(hour: 23, minute: 55))
        XCTAssertEqual(try? Timetable(from: "\(html[2])").days, [.saturday])
        XCTAssertEqual(try? Timetable(from: "\(html[3])").trips.count, 12)
        XCTAssertEqual(try? Timetable(from: "\(html[3])").trips.first?.origin?.time, Time(hour: 6, minute: 45))
        XCTAssertEqual(try? Timetable(from: "\(html[3])").trips.last?.destination?.time, Time(hour: 21, minute: 45))
        XCTAssertEqual(try? Timetable(from: "\(html[3])").days, [.sunday, .holiday])
    }
}
