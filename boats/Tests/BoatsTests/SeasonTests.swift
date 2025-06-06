import Testing
@testable import Boats
import Foundation

struct SeasonTests {
    
    // MARK: CustomAccessibilityStringConvertible
    @Test func accessibilityDescription() {
        #expect(Season(.spring, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1523678400.0), end: Date(timeIntervalSince1970: 1529121599.9))).accessibilityDescription == "Spring Schedule: April 14 through June 15, 2018")
        #expect(Season(.summer, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))).accessibilityDescription == "Summer Schedule: June 16 through September 3, 2018")
        #expect(Season(.fall, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1536033600.0), end: Date(timeIntervalSince1970: 1539057599.9))).accessibilityDescription == "Fall Schedule: September 4 through October 8, 2018")
        #expect(Season(.winter, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1539057600), end: Date(timeIntervalSince1970: 1546664399.9))).accessibilityDescription == "Winter Schedule: October 9, 2018 through January 4, 2019")
    }
    
    @Test func description() {
        #expect(Season(.spring, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1523678400.0), end: Date(timeIntervalSince1970: 1529121599.9))).description == "Spring: Apr 14-Jun 15, 2018")
        #expect(Season(.summer, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))).description == "Summer: Jun 16-Sep 3, 2018")
        #expect(Season(.fall, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1536033600.0), end: Date(timeIntervalSince1970: 1539057599.9))).description == "Fall: Sep 4-Oct 8, 2018")
        #expect(Season(.winter, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1539057600), end: Date(timeIntervalSince1970: 1546664399.9))).description == "Winter: Oct 9, 2018-Jan 4, 2019")
    }
}

extension SeasonTests {
    
    // MARK: HTMLConvertible
    @Test func htmlInit() throws {
        let html: [String] = try #require(String(data: HTML_Data, encoding: .utf8)?.find("<p[^>]*>(.*?)</p>"))
        #expect(html.count == 4)
        #expect(try Season(from: "\(html[0])").name == .spring)
        #expect(try Season(from: "\(html[0])").dateInterval.start.timeIntervalSince1970 == 1523678400.0)
        #expect(try Season(from: "\(html[0])").dateInterval.end.timeIntervalSince1970 == 1529121599.0)
        #expect(try Season(from: "\(html[1])").name == .summer)
        #expect(try Season(from: "\(html[1])").dateInterval.start.timeIntervalSince1970 == 1529121600.0)
        #expect(try Season(from: "\(html[1])").dateInterval.end.timeIntervalSince1970 == 1536033599.0)
        #expect(try Season(from: "\(html[2])").name == .fall)
        #expect(try Season(from: "\(html[2])").dateInterval.start.timeIntervalSince1970 == 1536033600.0)
        #expect(try Season(from: "\(html[2])").dateInterval.end.timeIntervalSince1970 == 1539057599.0)
        #expect(try Season(from: "\(html[3])").name == .winter)
        #expect(try Season(from: "\(html[3])").dateInterval.start.timeIntervalSince1970 == 1539057600.0)
        #expect(try Season(from: "\(html[3])").dateInterval.end.timeIntervalSince1970 == 1546664399.0)
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
