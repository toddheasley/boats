import Foundation
import Boats

struct Stylesheet: Resource {
    
    // MARK: Resource
    public let path: String = "stylesheet.css"
    
    public func data() throws -> Data {
        return Stylesheet_Data
    }
}

private let Stylesheet_Data: Data = """
:root {
    color-scheme: light dark;
}

a {
    color: inherit;
}

body {
    font-family: ui-sans-serif, sans-serif;
    margin: env(safe-area-inset-top) auto env(safe-area-inset-bottom) auto;
    max-width: 371px;
}

h1, h3 {
    font-size: 1em;
}

h2 {
    margin: 2em 0 0 0;
}

h3 {
    font-weight: normal;
    margin: 0;
}

table {
    border-collapse: collapse;
    margin: 1em 0;
    width: 100%;
}

td {
    max-width: 174px;
    width: 50%;
}

td, th {
    border: 1px solid;
    overflow: hidden;
    padding: 3px 5px;
    text-align: left;
    white-space: nowrap;
}

time b {
    display: inline-block;
    font-size: 2em;
    text-align: center;
    width: 0.75em;
}

time b:nth-child(3), time b:last-child {
    width: 0.35em;
}
""".data(using: .utf8)!
