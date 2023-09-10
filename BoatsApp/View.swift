import SwiftUI
import BoatsWeb

extension View {
    func backgroundColor(_ any: Color, dark: Color? = nil) -> some View {
        modifier(BackgroundColorModifier(any, dark: dark))
    }
    
    func backgroundColor() -> some View {
        return backgroundColor(.white, dark: .navy)
    }
    
    func foregroundColor(_ any: Color, dark: Color) -> some View {
        modifier(ForegroundColorModifier(any, dark: dark))
    }
    
    func shadow() -> some View {
        return shadow(color: .black.opacity(0.75), radius: 0.5, x: -0.5, y: 0.5)
    }
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
