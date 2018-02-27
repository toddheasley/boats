import Cocoa

extension NSColor {
    static let background: NSColor = .white
    static let text: NSColor = .black
    static let tint: NSColor = NSColor.text.withAlphaComponent(0.15)
    static let burn: NSColor = NSColor.text.withAlphaComponent(0.05)
    static let separator: NSColor = .darkGray
}
