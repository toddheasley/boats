# `BoatsKit`

`BoatsKit` is a Cocoa framework for macOS, iOS, watchOS and tvOS. It provides the complete [Casco Bay Lines](https://cascobaylines.com) ferry schedule as a modeled Swift interface and includes the following:

* Generating schedules automatically by crawling [cascobaylines.com](https://cascobaylines.com)
* Fetching the current schedule remotely from GitHub
* Organizing schedule data into understandable models
* `Date`-based querying of timetables and departures 

## Example Usage

Access to `BoatsKit` data is provided as a `URLSession` extension, so that it slots neatly into almost any Cocoa app's existing networking:

```swift
import BoatsKit

URLSession.shared.index(action: .fetch) { index, error in
    guard let index: Index = index else {
        print(error)
        return
    }
    for route in index.routes {
        print("\(route.name): \(route.schedule()?.season.description ?? "NA")")
    }
}

```

The default `action:` value is `fetch`, which remotely loads a pre-built, static [JSON file](https://toddheasley.github.io/boats/index.json); specifying `build` generates a new `Index` by scraping [cascobaylines.com](https://cascobaylines.com) directly.

To use `BoatsKit` as a freestanding Mac command line utility, archive the Xcode target `BoatsKitCLI` and run the resulting `boats` executable:

`./boats build /path/to/output`

There's also example code for iOS, watchOS and macOS in the [Boats](../Boats) and [BoatsEdit](../BoatsEdit) Xcode projects that are workspace-adjacent to this one.

## Requirements

`BoatsKit` is written in [Swift 5](https://docs.swift.org/swift-book) and requires [Xcode](https://developer.apple.com/xcode) 10.2 or newer to build.
