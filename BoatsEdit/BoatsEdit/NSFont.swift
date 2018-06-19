import Cocoa

extension NSFont {
    static let head: NSFont = .systemFont(ofSize: 19.0, weight: .bold)
    static let meta: NSFont = .systemFont(ofSize: 11.0, weight: .semibold)
    static let base: NSFont = .base(.regular)
    
    static func base(_ weight: NSFont.Weight) -> NSFont {
        return .systemFont(ofSize: 14.0, weight: weight)
    }
}
