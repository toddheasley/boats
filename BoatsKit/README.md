# `BoatsKit`

`BoatsKit` is a Swift package for macOS, iOS, watchOS and tvOS. It provides the complete [Casco Bay Lines](https://cascobaylines.com) ferry schedule as a modeled Swift interface and includes the following:

* Generating schedules automatically by crawling [cascobaylines.com](https://cascobaylines.com)
* Fetching the current schedule remotely from GitHub
* Organizing schedule data into understandable models
* `Date`-based querying of timetables and departures 

## Requirements

Supports apps targeting [iOS](https://developer.apple.com/ios)/[iPadOS](https://developer.apple.com/ipad)/[tvOS ](https://developer.apple.com/tvos) 13, as well as [watchOS](https://developer.apple.com/watchos) 6 and [macOS](https://developer.apple.com/macos) 10.15 Catalina. Written in [Swift](https://developer.apple.com/documentation/swift) 5.1 using the [Foundation](https://developer.apple.com/documentation/foundation) and [Core Location](https://developer.apple.com/documentation/corelocation) frameworks and requires [Xcode](https://developer.apple.com/xcode) 11 or newer to build.

## Example Usage

Access to `BoatsKit` data is provided as a `URLSession` extension, so that it slots neatly into almost any Cocoa app's existing networking:

```swift
import Foundation
import BoatsKit

URLSession.shared.index(action: .fetch) { index, error in
    guard let index: Index = index else {
        print(error)
        return
    }
    for route in index.routes {
        print("\(route.name): \(route.schedule()?.season ?? "")")
    }
}
```

The default `action:` value is `fetch`, which remotely loads a pre-built, static [JSON file](https://toddheasley.github.io/boats/index.json); specifying `build` generates a new `Index` by scraping [cascobaylines.com](https://cascobaylines.com) directly.
