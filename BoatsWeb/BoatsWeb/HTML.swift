//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

struct HTML: ExpressibleByArrayLiteral, ExpressibleByStringLiteral, CustomStringConvertible {
    typealias ArrayLiteralElement = HTML
    private var value: String?
    var elements: [HTML] = []
    
    var description: String {
        if elements.isEmpty,
            let value = value {
            return "\(value)"
        }
        return elements.map { element in
            "\(element)"
        }.joined()
    }
    
    init(stringLiteral value: String) {
        self.value = value
    }
    
    init(arrayLiteral elements: HTML...) {
        self.elements = elements
    }
}

extension HTML {
    static func document(html: HTML) -> HTML {
        var document: HTML = ""
        document.elements.append(line("<!DOCTYPE html>"))
        for element in html.elements {
            document.elements.append(line(element))
        }
        return document
    }
    
    static func head(title: String) -> HTML {
        var html: HTML = ""
        html.elements.append(HTML.title(string: title))
        html.elements.append(HTML.meta(name: "viewport", content: "initial-scale=1.0"))
        html.elements.append(HTML.meta(name: "apple-mobile-web-app-title", content: "\(Site.name)"))
        if let appIdentifier = Site.appIdentifier, !appIdentifier.isEmpty {
            html.elements.append(HTML.meta(name: "apple-itunes-app", content: "app-id=\(appIdentifier)"))
        }
        html.elements.append(HTML.link(rel: "apple-touch-icon", href: "\(BookmarkIcon().uri.path)"))
        html.elements.append(HTML.link(rel: "stylesheet", href: "\(Stylesheet().uri.path)"))
        return head(html: html)
    }
    
    static func head(html: HTML) -> HTML {
        var head: HTML = ""
        head.elements.append(line("<head>"))
        for element in html.elements {
            head.elements.append(line(tab(element)))
        }
        head.elements.append("</head>")
        return head
    }
    
    static func body(html: HTML) -> HTML {
        var body: HTML = ""
        body.elements.append(line("<body>"))
        for element in html.elements {
            body.elements.append(line(tab(element)))
        }
        body.elements.append("</body>")
        return body
    }
    
    static func header(h1: String, h2: String) -> HTML {
        var html: HTML = ""
        html.elements.append(HTML.h(level: 1, html: HTML(stringLiteral: h1)))
        html.elements.append(HTML.h(level: 2, html: HTML(stringLiteral: h2)))
        return header(html: html)
    }
    
    static func header(html: HTML) -> HTML {
        var header: HTML = ""
        header.elements.append(line("<header>"))
        for element in html.elements {
            header.elements.append(line(tab(element)))
        }
        header.elements.append("</header>")
        return header
    }
    
    static func main(html: HTML) -> HTML {
        var main: HTML = ""
        main.elements.append(line("<main>"))
        for element in html.elements {
            main.elements.append(line(tab(element)))
        }
        main.elements.append("</main>")
        return main
    }
    
    static func footer(html: HTML) -> HTML {
        var footer: HTML = ""
        footer.elements.append(line("<footer>"))
        for element in html.elements {
            footer.elements.append(line(tab(element)))
        }
        footer.elements.append("</footer>")
        return footer
    }
    
    static func nav(href: String) -> HTML {
        return HTML(stringLiteral: "<nav>\(a(href: href, html: svg(SVG.menu)))</nav>")
    }
    
    static func title(string: String) -> HTML {
        return HTML(stringLiteral: "<title>\(title)</title>")
    }
    
    static func meta(name: String, content: String) -> HTML {
        return HTML(stringLiteral: "<meta name=\"\(name)\" content=\"\(content)\">")
    }
    
    static func link(rel: String, href: String) -> HTML {
        return HTML(stringLiteral: "<link rel=\"\(rel)\" href=\"\(href)\">")
    }
    
    static func h(level: Int, html: HTML) -> HTML {
        return HTML(stringLiteral: "<h\(min(max(level, 1), 6))>\(html)</h\(min(max(level, 1), 6))>")
    }
    
    static func a(href: String, html: HTML) -> HTML {
        return HTML(stringLiteral: "<a href=\"\(href)\">\(html)</a>")
    }
    
    static func svg(_ svg: SVG) -> HTML {
        guard let data: Data = try? svg.data(),
            let string: String = String(data: data, encoding: .utf8) else {
            return HTML(stringLiteral: "\(svg.rawValue)")
        }
        return HTML(stringLiteral: string.components(separatedBy: "\n").map { string in
            string.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " xmlns=\"http://www.w3.org/2000/svg\"", with: "")
        }.joined())
    }
    
    static func tab(_ html: HTML) -> HTML {
        return HTML(stringLiteral: "    \(html)")
    }
    
    static func line(_ html: HTML) -> HTML {
        return HTML(stringLiteral: "\(html)\n")
    }
}
