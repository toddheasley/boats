# `Boats` Package

Libraries that build and drive Boats apps and web pages

### Requirements

Written in [Swift](https://developer.apple.com/documentation/swift) 5.7 using [Foundation](https://developer.apple.com/documentation/foundation) and [Core Location.](https://developer.apple.com/documentation/corelocation) Command-line interface depends on [Swift Argument Parser.](https://github.com/apple/swift-argument-parser) Requires [Xcode](https://developer.apple.com/xcode) 14 or newer to build.

#### Platform Targets

* [macOS](https://developer.apple.com/macos) 13 Ventura
* [iOS](https://developer.apple.com/ios)/[iPadOS](https://developer.apple.com/ipad)/[tvOS ](https://developer.apple.com/tvos) 16
* [watchOS](https://developer.apple.com/watchos) 9

## `BoatsCLI`

Fetch, build and debug Boats schedules and web pages using a scriptable command-line interface.

![](../docs/boats-cli.png)

### Example Usage

Archive `boats-cli` target and move executable to a clean working directory. From any shell, `fetch` schedule data as a [pre-built JSON file](https://toddheasley.github.io/boats/index.json) off GitHub:

```zsh
./boats-cli fetch
```

Scrape new schedule data from [cascobaylines.com](https://www.cascobaylines.com) directly:

```zsh
./boats-cli build
```

Rebuild existing local schedule data and generate static web pages:

```zsh
./boats-cli debug -w
```

## `BoatsWeb`

`BoatsWeb` extends the functionality of `Boats` to include:

* Generating static web pages from schedule data

### Example Usage

```swift
import Boats
import BoatsWeb

let index: Index = try Index(from: FileManager.default.temporaryDirectory)
try Site(index).build(to: FileManager.default.temporaryDirectory)
```

## `Boats`

`Boats` provides the complete Casco Bay Lines ferry schedule as a modeled interface that handles:

* Generating schedules automatically by crawling [cascobaylines.com](https://www.cascobaylines.com)
* Fetching the current schedule remotely from GitHub
* `Date`-based querying of timetables and departures
* Caching schedules for offline use

### Example Usage

```swift
import Boats

let index: Index = try await URLSession.shared.index(.build)
try index.build(to: FileManager.default.temporaryDirectory)
```
