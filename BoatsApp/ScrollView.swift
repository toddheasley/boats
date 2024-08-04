import SwiftUI

struct ScrollView<Content: View>: View {
    init(_ axes: Axis.Set = .vertical, showsIndicators: Bool = true, onScroll: ((CGPoint) -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.onScroll = onScroll
        self.content = content
    }
    
    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let onScroll: ((CGPoint) -> Void)?
    private let content: () -> Content
    
    // MARK: View
    var body: some View {
        SwiftUI.ScrollView(axes, showsIndicators: showsIndicators) {
            ZStack(alignment: .top) {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: OffsetPreferenceKey.self, value: proxy.frame(in: .named("offset")).origin)
                }
                content()
            }
        }
        .coordinateSpace(name: "offset")
        .onPreferenceChange(OffsetPreferenceKey.self) { offset in
            onScroll?(offset)
        }
        .contentMargins(.top, -0.1, for: .scrollIndicators)
    }
}

#Preview("Scroll View") {
    ScrollView(onScroll: { offset in
        print(offset)
    }) {
        Rectangle()
            .fill(Color.haze)
            .frame(height: 2048.0)
    }
}

// MARK: OffsetPreferenceKey
private struct OffsetPreferenceKey: PreferenceKey {
    
    // MARK: PreferenceKey
    static let defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        
    }
}
