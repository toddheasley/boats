import XCTest
@testable import BoatsWeb

class HTMLTests: XCTestCase, HTMLDataSource {
    
    // MARK: HTMLConvertible
    func testHTML() {
        guard let template: String = String(data: HTML_Data, encoding: .utf8) else {
            XCTFail()
            return
        }
        var html: HTML = HTML(template: template)
        XCTAssertThrowsError(try html.html())
        html.dataSource = self
        XCTAssertNoThrow(try html.html())
        XCTAssertEqual(try? html.html(), "<title>A</title>\n<h1>A</h1>\n<p>0</p>\n<p>1</p>\n<p>2</p>")
    }
    
    // MARK: HTMLDataSource
    func template(of name: String, at index: [Int]) -> String? {
        return !index.isEmpty ? "\(index[0])" : "A"
    }
    
    func count(of name: String, at index: [Int]) -> Int {
        return 3
    }
}

extension HTMLTests {
    func testDataInit() {
        XCTAssertNoThrow(try HTML(data: HTML_Data))
        XCTAssertEqual(try? HTML(data: HTML_Data).template, "<title><!-- HTML --></title>\n<!-- HTML? -->\n<h1><!-- HTML --></h1>\n<!-- ?HTML -->\n<!-- HTML[ -->\n<p><!-- HTML --></p>\n<!-- ]HTML -->")
    }
    
    func testData() {
        guard let template: String = String(data: HTML_Data, encoding: .utf8) else {
            XCTFail()
            return
        }
        var html: HTML = HTML(template: template)
        html.dataSource = self
        XCTAssertNoThrow(try html.data())
        XCTAssertEqual(try? html.data(), ((try? html.html().data(using: .utf8)) as Data??))
    }
}

private let HTML_Data: Data = """
<title><!-- HTML --></title>
<!-- HTML? -->
<h1><!-- HTML --></h1>
<!-- ?HTML -->
<!-- HTML[ -->
<p><!-- HTML --></p>
<!-- ]HTML -->
""".data(using: .utf8)!
