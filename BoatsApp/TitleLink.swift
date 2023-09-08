import SwiftUI
import BoatsWeb

struct TitleLink: View {
    let destination: URL
    let title: String?
    
    init(_ title: String?, destination: URL) {
        self.destination = destination
        self.title = title
    }
    
    // MARK: View
    var body: some View {
        if let title {
            HStack {
#if os(macOS)
                Spacer()
#endif
                Link(destination: destination) {
                    Text(title)
                        .lineLimit(1)
                }
                Spacer()
            }
        }
    }
}

#Preview("Title Link") {
    TitleLink("Casco Bay Lines", destination: URL(string: "https://cascobaylines.com")!)
        .backgroundColor(.haze)
}
