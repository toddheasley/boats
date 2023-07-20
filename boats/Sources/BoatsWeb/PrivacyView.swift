import SwiftUI
import Boats

struct PrivacyView: HTMLView, CustomStringConvertible {
    let title: String = "Boats Privacy"
    
    // MARK: HTMLView
    var html: [String] {
        var html: [String] = []
        html.append("<!DOCTYPE html>")
        html.append("<meta charset=\"UTF-8\">")
        html.append(meta("viewport", content: "initial-scale=1.0"))
        html.append(meta("og:title", content: title))
        html.append(meta("og:description", content: description))
        html.append(link("apple-touch-icon", href: BookmarkIcon().path))
        html.append(link("shortcut icon", href: Favicon().path))
        html.append("<title>\(title)</title>")
        html.append("<h1>\(title)</h1>")
        html.append("<h2><em>\(description.capitalized)</em></h2>")
        html.append("<p>Boats is available for Apple platforms and subject to <a href=\"https://www.apple.com/privacy\">Apple privacy</a> guidelines and labeling. Schedule data is scraped robotically from <a href=\"https://www.cascobaylines.com\">cascobaylines.com</a> and hosted with <a href=\"https://pages.github.com\">GitHub&nbsp;Pages.</a> Boats does not include any analytics or logging capabilities.</p>")
        html.append("<p>The entire Boats source code is <a href=\"https://github.com/toddheasley/boats\">publicly available on GitHub</a> under the <a href=\"https://choosealicense.com/licenses/mit\">MIT&nbsp;License.</a></p>")
        html.append("<p><a href=\"javascript:window.print()\">🖨️</a></p>")
        html.append(style)
        return html
    }
    
    let uri: String = "privacy"
    
    // MARK: CustomStringConvertible
    var description: String {
        return "Data not collected"
    }
}

private func meta(_ name: String, content: String) -> String {
    return "<meta name=\"\(name)\" content=\"\(content)\">"
}

private func link(_ rel: String, href: String) -> String {
    return "<link rel=\"\(rel)\" href=\"\(href)\">"
}

private let style: String = """
<style>
    
    :root {
        color-scheme: light dark;
        --background-color: white;
        -webkit-text-size-adjust: 100%;
    }
    
    @media (prefers-color-scheme: dark) {
        :root {
            --background-color: rgb(32, 61, 83);
        }
    }
    
    * {
        margin: 0;
    }
    
    body {
        font-family: ui-sans-serif, sans-serif;
    }
    
    h1, h2, p {
        font-size: 1em;
        margin: 1em 0;
    }
    
    h2 em {
        font-size: 1.25em;
        opacity: 0.9;
    }
    
    @media screen {
        a {
            color: rgb(44, 103, 212);
        }
        
        a[href^="javascript:"] {
            font-size: 2em;
            text-decoration: none;
        }
        
        body {
            background: var(--background-color);
            font-size: 15px;
            margin: 1em;
        }
    }
    
    @media print {
        a {
            color: inherit;
            text-decoration: none;
        }
        
        a[href^="javascript:"], a[href^="#"] {
            display: none;
        }
        
        body {
            font-size: 10pt;
        }
    }
    
</style>
"""
