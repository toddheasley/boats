# `BoatsWeb`

`BoatsWeb` is a Swift package for macOS and iOS. It extends the functionality of [`BoatsKit`](../BoatsKit) to include:

* Generating static web pages from schedule data

## Requirements

Supports apps targeting [iOS](https://developer.apple.com/ios)/[iPadOS](https://developer.apple.com/ipad) and [macOS](https://developer.apple.com/macos) 10.15 Catalina. Written in [Swift](https://developer.apple.com/documentation/swift) 5.1 using the [Foundation](https://developer.apple.com/documentation/foundation) framework and requires [Xcode](https://developer.apple.com/xcode) 11 or newer to build.

## Example Usage

```swift
import Foundation
import BoatsKit
import BoatsWeb

do {
    let index: Index = try Index(from: URL(fileURLWithPath: "/path/to/input"))
    try Site(index: index).build(to: URL(fileURLWithPath: "/path/to/output"))
} catch {
    print(error)
}
```
