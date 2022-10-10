import XCTest
@testable import Boats

class SeasonTests: XCTestCase {
    
    // MARK: StringConvertible
    func testDescription() {
        XCTAssertEqual(Season(name: .spring, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1523678400.0), end: Date(timeIntervalSince1970: 1529121599.9))).description, "Spring: Apr 14-Jun 15, 2018")
        XCTAssertEqual(Season(name: .summer, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))).description(.sentence), "Summer: Jun 16-Sep 3, 2018")
        XCTAssertEqual(Season(name: .fall, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1536033600.0), end: Date(timeIntervalSince1970: 1539057599.9))).description(.title), "Fall: Sep 4-Oct 8, 2018")
        XCTAssertEqual(Season(name: .winter, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1539057600), end: Date(timeIntervalSince1970: 1546664399.9))).description, "Winter: Oct 9, 2018-Jan 4, 2019")
        XCTAssertEqual(Season(name: .summer, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))).description(.abbreviated), "Summer")
        XCTAssertEqual(Season(name: .summer, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))).description(.compact), "summer")
    }
}

extension SeasonTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() {
        guard let html: [String] = String(data: HTML_Data, encoding: .utf8)?.find("<p[^>]*>(.*?)</p>"), html.count == 4 else {
            XCTFail()
            return
        }
        XCTAssertEqual(try? Season(from: "\(html[0])").name, .spring)
        XCTAssertEqual(try? Season(from: "\(html[0])").dateInterval.start.timeIntervalSince1970, 1523678400.0)
        XCTAssertEqual(try? Season(from: "\(html[0])").dateInterval.end.timeIntervalSince1970, 1529121599.0)
        XCTAssertEqual(try? Season(from: "\(html[1])").name, .summer)
        XCTAssertEqual(try? Season(from: "\(html[1])").dateInterval.start.timeIntervalSince1970, 1529121600.0)
        XCTAssertEqual(try? Season(from: "\(html[1])").dateInterval.end.timeIntervalSince1970, 1536033599.0)
        XCTAssertEqual(try? Season(from: "\(html[2])").name, .fall)
        XCTAssertEqual(try? Season(from: "\(html[2])").dateInterval.start.timeIntervalSince1970, 1536033600.0)
        XCTAssertEqual(try? Season(from: "\(html[2])").dateInterval.end.timeIntervalSince1970, 1539057599.0)
        XCTAssertEqual(try? Season(from: "\(html[3])").name, .winter)
        XCTAssertEqual(try? Season(from: "\(html[3])").dateInterval.start.timeIntervalSince1970, 1539057600.0)
        XCTAssertEqual(try? Season(from: "\(html[3])").dateInterval.end.timeIntervalSince1970, 1546664399.0)
    }
}

private let HTML_Data: Data = """
<p style="text-align: center;">
    <strong>Currently Displaying:</strong>
     Spring Schedule
    <br/>
    <strong>Effective: </strong>
    April 14, 2018 &#8211; June 15, 2018
    <br/>
    <strong>
        KEY:
        <em> cf</em>
    </strong>
    <em> = car ferry (transports cars and passengers)</em>
</p>

<p style="text-align: center;">
    <strong>Currently Displaying:</strong>
     Summer Schedule
    <br/>
    <strong>Effective: </strong>
    June 16, 2018 &#8211; September 3, 2018
    <br/>
    <strong>
        KEY:
        <em> XF</em>
    </strong>
    <em>
         = Except Friday,
        <strong>FO</strong>
         = Friday Only
    </em>
</p>

<p style="text-align: center;">
    <strong>Currently Displaying:</strong>
     Fall Schedule
    <br/>
    <strong>Effective: </strong>
    September 4, 2018 &#8211; October 8, 2018
    <br/>
    <strong>
        KEY:
        <em> XF</em>
    </strong>
    <em>
         = Except Friday,
        <strong>FO</strong>
         = Friday Only
    </em>
</p>
<p style="text-align: center;">
    <strong>Currently Displaying:</strong>
     Winter Schedule
    <br/>
    <strong>Effective: </strong>
    October 9, 2018 &#8211; January 4, 2019
    <br/>
    <strong>
        KEY:
        <em> XF</em>
    </strong>
    <em>
         = Except Friday,
        <strong>FO</strong>
         = Friday Only
    </em>
</p>
""".data(using: .utf8)!
