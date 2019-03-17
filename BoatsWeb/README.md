# `BoatsWeb`

`BoatsWeb` is a Cocoa framework for macOS and iOS. It extends the functionality of [`BoatsKit`](../BoatsKit) to include:

* Generating static web pages from schedule data

## Example Usage

```swift
import BoatsKit
import BoatsWeb

do {
    let index: Index = try Index(from: URL(fileURLWithPath: "/path/to/input"))
    try Site(index: index).build(to: URL(fileURLWithPath: "/path/to/output"))
} catch {
    print(error)
}

```

Example code for macOS can be found in the [BoatsEdit](../BoatsEdit) Xcode project that's workspace-adjacent to this one.

## Requirements

`BoatsWeb` is written in [Swift 5](https://docs.swift.org/swift-book) and requires [Xcode](https://developer.apple.com/xcode) 10.2 or newer to build.
