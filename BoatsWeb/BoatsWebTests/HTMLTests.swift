import XCTest
@testable import BoatsWeb

class HTMLTests: XCTestCase, HTMLDataSource {
    func testCustomStringConvertible() {
        guard let data: Data = data(for: .mock, type: "html"),
            let string: String = String(data: data, encoding: .utf8) else {
            XCTFail()
            return
        }
        let html: HTML = HTML(stringLiteral: string)
        html.dataSource = self
        XCTAssertEqual("\(html)", "<title>A</title>\n<h1>A</h1>\n<p>0</p>\n<p>1</p>\n<p>2</p>")
    }
    
    // MARK: HTMLDataSource
    func value(of name: String, at index: [Int], in html: HTML) -> String? {
        if !index.isEmpty {
            return "\(index[0])"
        }
        return "A"
    }
    
    func count(of name: String, at index: [Int], in html: HTML) -> Int {
        return 3
    }
}
