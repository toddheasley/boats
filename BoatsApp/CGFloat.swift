import CoreGraphics

extension CGFloat {
#if os(tvOS)
    static let maxWidth: Self? = nil
#else
    static let maxWidth: Self = 384.0
#endif
    static let spacing: Self = 3.5
}
