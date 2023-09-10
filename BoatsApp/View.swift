import SwiftUI
import BoatsWeb

extension View {
    func clipped(corners radii: [CGFloat], style: RoundedCornerStyle = .continuous) -> some View {
        let radii: [CGFloat] = radii.count == 4 ? radii : Array(repeating: radii.first ?? 0.0, count: 4)
        return clipShape(.rect(topLeadingRadius: radii[0], bottomLeadingRadius: radii[1], bottomTrailingRadius: radii[2], topTrailingRadius: radii[3], style: style))
    }
    
    func clipped(corners radii: CGFloat, style: RoundedCornerStyle = .default) -> some View {
        return clipped(corners: [radii, radii, radii, radii], style: style)
    }
    
    func backgroundColor(_ any: Color, dark: Color? = nil) -> some View {
        return modifier(BackgroundColorModifier(any, dark: dark))
    }
    
    func backgroundColor() -> some View {
        return backgroundColor(.white, dark: .navy)
    }
    
    func foregroundColor(_ any: Color, dark: Color) -> some View {
        return modifier(ForegroundColorModifier(any, dark: dark))
    }
    
    func shadow() -> some View {
        return shadow(color: .black.opacity(0.75), radius: 0.5, x: -0.5, y: 0.5)
    }
}

#Preview("Clipped Corners") {
    Rectangle()
        .clipped(corners: [50.0, 0.0, 25.0, 0.0])
}

#Preview("Background Color") {
    Rectangle()
        .fill(Color.clear)
        .backgroundColor()
}

#Preview("Foreground Color") {
    Rectangle()
        .foregroundColor(.navy, dark: .white)
}

#Preview("Shadow") {
    Rectangle()
        .fill(Color.aqua)
        .frame(width: 128.0, height: 128.0)
        .shadow()
}

private extension RoundedCornerStyle {
    static let `default`: Self = .continuous
}

private struct BackgroundColorModifier: ViewModifier {
    let color: (any: Color, dark: Color?)
    
    var resolvedColor: Color {
        switch colorScheme {
        case .dark:
            return color.dark ?? color.any
        default:
            return color.any
        }
    }
    
    init(_ any: Color, dark: Color? = nil) {
        self.color = (any, dark)
    }
    
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: ViewModifier
    func body(content: Content) -> some View {
        content.background(resolvedColor)
    }
}

private struct ForegroundColorModifier: ViewModifier {
    let color: (any: Color, dark: Color)
    
    var resolvedColor: Color {
        switch colorScheme {
        case .dark:
            return color.dark
        default:
            return color.any
        }
    }
    
    init(_ any: Color, dark: Color) {
        self.color = (any, dark)
    }
    
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: ViewModifier
    func body(content: Content) -> some View {
        content.foregroundColor(resolvedColor)
    }
}
