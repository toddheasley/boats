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
        html.append("<p>Boats app adheres to <a href=\"https://developer.apple.com/app-store/app-privacy-details\">App Store privacy labeling</a> as follows:</p>")
        html.append("<blockquote>")
        html.append("    <p>\(label)<br><b>Data Not Collected</b><br>The developer does not collect any data for this app.</p>")
        html.append("</blockquote>")
        html.append("<p>The entire Boats source code is <a href=\"https://github.com/toddheasley/boats\">available on GitHub.</a></p>")
        html.append(style)
        return html
    }
    
    let uri: String = "privacy"
    
    // MARK: CustomStringConvertible
    var description: String { "Data not collected" }
}

private func meta(_ name: String, content: String) -> String {
    "<meta name=\"\(name)\" content=\"\(content)\">"
}

private func link(_ rel: String, href: String) -> String {
    "<link rel=\"\(rel)\" href=\"\(href)\">"
}

private let label: String = """
<svg width="44" height="44"><path d="M22,39 C31.3833333,39 39,31.3833333 39,22 C39,12.6166667 31.3833333,5 22,5 C12.6166667,5 5,12.6166667 5,22 C5,31.3833333 12.6166667,39 22,39 Z M22,36 C14.2588235,36 8,29.7411765 8,22 C8,14.2588235 14.2588235,8 22,8 C29.7411765,8 36,14.2588235 36,22 C36,29.7411765 29.7411765,36 22,36 Z M19.7768053,30 C20.3183807,30 20.7778993,29.7345133 21.1061269,29.2201327 L28.6061269,17.289823 C28.7866521,16.9579646 29,16.5929204 29,16.2278761 C29,15.4811947 28.3435449,15 27.654267,15 C27.2439825,15 26.833698,15.2654867 26.5218818,15.7466814 L19.7111597,26.7975664 L16.4781182,22.5663717 C16.0842451,22.0353982 15.7231947,21.9026549 15.2636761,21.9026549 C14.5579869,21.9026549 14,22.4834071 14,23.2134956 C14,23.5785398 14.1477024,23.9269912 14.3774617,24.2422566 L18.3818381,29.2201327 C18.7921225,29.7676991 19.2352298,30 19.7768053,30 Z"></path></svg>
"""

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
    
    blockquote p {
        margin: 1em;
    }
    
    blockquote svg {
        fill: CanvasText;
    }
    
    body {
        font-family: ui-sans-serif, sans-serif;
    }
    
    h1, p {
        font-size: 1em;
        margin: 1em 0;
    }
    
    @media screen {
        a {
            color: rgb(44, 103, 212);
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
        
        body {
            font-size: 10pt;
        }
    }
    
</style>
"""
