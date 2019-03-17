# BoatsEdit

BoatsEdit is a macOS utility that streamlines the process of updating Casco Bay Lines schedule data, including:

* Generating new schedules automatically by crawling [cascobaylines.com](https://cascobaylines.com)
* Fetching the current schedule remotely from GitHub
* Validating and previewing schedules

![](BoatsEdit.png)

## Architecture

BoatsEdit is a glorified instance of `NSOpenPanel` that marshals the [`BoatsKit`](../BoatsKit) and [`BoatsWeb`](../BoatsWeb) frameworks.

Using `AppKit` is overkill for, effectively, two buttons that can be automated away. BoatsEdit will be replaced by a `--web` flag for the [`boats` CLI](../BoatsKit) as soon as I find the most elegant way to bake the external HTML templates, SVGs, images and CSS required by `BoatsWeb` into the compiled CLI executable; even as a stopgap, linking the frameworks and/or resources is just too fiddly for my taste.

## Requirements

BoatsEdit is written in [Swift 5](https://docs.swift.org/swift-book) and requires [Xcode](https://developer.apple.com/xcode) 10.2 or newer to build.
