import SwiftUI
import BoatsWeb

struct Cell<Content: View>: View {
    let alignment: HorizontalAlignment
    let content: () -> Content
    
    init(alignment: HorizontalAlignment = .leading, @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.content = content
    }
    
    // MARK: View
    var body: some View {
        HStack {
            if alignment != .leading {
                Spacer()
            }
            content()
            if alignment != .trailing {
                Spacer()
            }
        }
    }
}

#Preview("Cell") {
    VStack(spacing: .spacing) {
        Cell {
            Text("Cell")
        }
        .backgroundColor(.haze)
        Cell(alignment: .trailing) {
            Text("Cell")
        }
        .backgroundColor(.haze)
        Cell(alignment: .center) {
            Text("Cell")
        }
        .backgroundColor(.haze)
    }
}
