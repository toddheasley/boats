import Cocoa

extension NSColor {
    static let background: NSColor = .white
    static let text: NSColor = .black
    static let separator: NSColor = .darkGray
    static let tint: NSColor = .tint(emphasized: true)
    
    static func tint(emphasized: Bool) -> NSColor {
        return NSColor.text.withAlphaComponent(emphasized ? 0.075 : 0.05)
    }
}
