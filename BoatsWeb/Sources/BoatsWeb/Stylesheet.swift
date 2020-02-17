import Foundation
import BoatsKit

struct Stylesheet {
    
}

extension Stylesheet: Resource {
    
    // MARK: Resource
    public var path: String {
        return "stylesheet.css"
    }
    
    public func data() throws -> Data {
        return Stylesheet_Data
    }
}

private let Stylesheet_Data: Data = """
:root {
    --background: rgb(251, 251, 251);
    --color: rgb(25, 25, 25);
}

@media (prefers-color-scheme: dark) {
    :root {
        --background: rgb(25, 25, 25);
        --color: rgb(251, 251, 251);
    }
}

* {
    margin: 0;
    padding: 0;
}

a {
    color: inherit;
}

body {
    -webkit-text-size-adjust: none;
    background: var(--background);
    color: var(--color);
    filter: grayscale(100%);
    font-family: -apple-system, sans-serif;
    font-size: 16px;
    margin: 1em auto;
    position: relative;
    width: 298px;
}

header h1 {
    font-size: 1em;
    margin: 1em 2px;
}

main h1 {
    font-size: 24px;
    margin: 2px;
}

main h2 {
    height: 32px;
}

main h2 small {
    background: var(--color);
    border-style: outset;
    color: var(--background);
    display: inline-block;
    font-size: 12px;
    padding: 2px 6px;
}

nav {
    position: absolute;
    right: 2px;
    top: 0px;
}

nav a {
    display: block;
    text-decoration: none;
}

section {
    border-style: outset;
    margin: 1em 0;
}

section h3 {
    font-size: 1em;
    padding: 2px 6px;
}

section h3 small {
    display: block;
}

small {
    font-size: 12px;
}

table {
    width: 100%;
}

td, th {
    border-style: inset;
}

td {
    white-space: nowrap;
}

td a {
    display: block;
    padding: 3px 2px;
    position: relative;
    text-decoration: none;
    vertical-align: middle;
}

td a b {
    font-size: 24px;
    height: 32px;
    margin-right: 2px;
    vertical-align: middle;
}

td small {
    background: var(--color);
    border-radius: 1px;
    color: var(--background);
    display: inline-block;
    font-size: 8px;
    overflow: hidden;
    padding: 1px;
    text-align: center;
    vertical-align: middle;
    white-space: normal;
    width: 29px;
}

th {
    text-align: left;
    padding: 2px;
}

th small {
    display: block;
    width: 134px;
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
}

time {
    display: inline-block;
    font-size: 27px;
    height: 32px;
    vertical-align: middle;
}

time b {
    display: inline-block;
    text-align: center;
    width: 20px;
}

time b:nth-child(3), time b:last-child {
    width: 10px;
}
""".data(using: .utf8)!
