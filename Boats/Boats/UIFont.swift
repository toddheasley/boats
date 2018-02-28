import UIKit

extension UIFont {
    static let time: UIFont = .systemFont(ofSize: 64.0, weight: .bold)
    static let mast: UIFont = .systemFont(ofSize: 34.0, weight: .bold)
    static let head: UIFont = .systemFont(ofSize: 19.0, weight: .bold)
    static let meta: UIFont = .systemFont(ofSize: 9.0, weight: .bold)
    static let base: UIFont = .base(.regular)
    
    static func base(_ weight: UIFont.Weight) -> UIFont {
        return .systemFont(ofSize: 14.0, weight: weight)
    }
}
