import SwiftUI

extension View {
    func backgroundColor() -> some View {
        return background {
            Color.background
        }
    }
    
    func cellPadding() -> some View {
        return padding(.cellSpacing)
    }
    
    func safeAreaInset<V>(_ edge: VerticalEdge, alignment: Alignment = .center, height: CGFloat = 0.0, @ViewBuilder content: () -> V = {
        EmptyView()
    }) -> some View where V : View {
        return safeAreaInset(edge: edge, alignment: alignment.horizontal, spacing: 0.0) {
            ZStack(alignment: alignment) {
                Rectangle()
                    .frame(height: height)
                    .hidden()
                content()
            }
        }
    }
}

struct View_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        Rectangle()
            .fill(Color.clear)
            .backgroundColor()
            .previewDisplayName("Background Color")
        Rectangle()
            .fill(Color.clear)
            .frame(height: 44.0)
            .background()
            .cellPadding()
            .background {
                Color.previewColor
            }
            .padding()
            .previewDisplayName("Cell Padding")
        Rectangle()
            .fill(Color.previewColor)
            .safeAreaInset(.top, height: 44.0)
            .safeAreaInset(.bottom) {
                Rectangle()
                    .fill(Color.previewColor)
                    .frame(height: 32.0)
                    .padding()
            }
            .previewDisplayName("Safe Area Inset")
    }
}

extension CGFloat {
    static let cellSpacing: Self = 3.5
}
