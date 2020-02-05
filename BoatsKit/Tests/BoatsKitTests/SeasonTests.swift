import XCTest
@testable import BoatsKit

class SeasonTests: XCTestCase {
    
}

extension SeasonTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Season(name: .spring, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1523678400.0), end: Date(timeIntervalSince1970: 1529121599.9))).description, "Spring: Apr 14-Jun 15, 2018")
        XCTAssertEqual(Season(name: .summer, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))).description, "Summer: Jun 16-Sep 3, 2018")
        XCTAssertEqual(Season(name: .fall, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1536033600.0), end: Date(timeIntervalSince1970: 1539057599.9))).description, "Fall: Sep 4-Oct 8, 2018")
        XCTAssertEqual(Season(name: .winter, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1539057600), end: Date(timeIntervalSince1970: 1546664399.9))).description, "Winter: Oct 9, 2018-Jan 4, 2019")
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
<p style="text-align: center;"><span style="font-size: large;"> <strong><strong>Currently Displaying:</strong> </strong><em>Spring Schedule</em><strong><strong><br />
    <strong>Effective: </strong></strong></strong><span style="line-height: 1.5em;">April 14, 2018 &#8211; June 15, 2018<br />
        <strong>FO = Friday Only</strong><br />
    </span></span></p>
<p style="text-align: center;"><span style="font-size: large;"><strong><strong><strong>Currently Displaying:</strong> </strong></strong><em>Summer Schedule</em><strong><strong><br />
    <strong>Effective: </strong></strong></strong>June 16, 2018 &#8211; September 3, 2018<br />
</span><span style="line-height: 1.5em;"><strong>KEY: </strong><strong>fo</strong> = Friday only; <strong>xh</strong> = except holidays</span></p>

<p style="text-align: center;"><span style="font-size: large;"><strong><strong><strong>Currently Displaying:</strong> </strong></strong><em>Fall Schedule</em><strong><strong><br />
    <strong>Effective: </strong></strong></strong>September 4, 2018 &#8211; October 8, 2018<br />
</span><span style="line-height: 1.5em;"><strong>KEY: </strong><strong>xh</strong> = except holidays</span></p>

<p style="text-align: center;"><span style="font-size: large;"><strong>Currently Displaying:</strong> Winter Schedule </span><br />
<span style="font-size: large;"><strong>Effective: </strong>October 9, 2018 &#8211; January 4, 2019</span><br />
<strong>KEY:</strong><em><strong> cf</strong> = car ferry (transports cars and passengers)</em></p>
""".data(using: .utf8)!
