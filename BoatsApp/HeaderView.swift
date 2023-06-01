import SwiftUI
import Boats

struct HeaderView: View {
    init(_ offset: CGPoint = .zero) {
        self.offset = offset
    }
    
    @EnvironmentObject private var index: ObservableIndex
    private let insets: EdgeInsets = EdgeInsets(top: 32.0, leading: 0.0, bottom: 0.0, trailing: 0.0 )
    private let offset: CGPoint
    
    // MARK: View
    var body: some View {
        ZStack {
            HStack {
                Link(destination: index.url) {
                    Text(index.name)
                        .underline()
                }
                Spacer()
                MainMenu()
            }
            .padding(.horizontal)
            .opacity(offset.y < -1.0 ? 0.0 : 1.0)
            VStack(spacing: 0.0) {
                TitleView(index.route?.location.name)
                    .padding(.horizontal)
                    .offset(y: max(insets.top + offset.y, 0.0))
                Divider()
                    .opacity(offset.y > -insets.top ? 0.0 : 1.0)
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    @StateObject private static var index = ObservableIndex()
    
    // MARK: PreviewProvider
    static var previews: some View {
        Rectangle()
            .fill(Color.clear)
            .safeAreaInset(.top) {
                HeaderView()
            }
            .environmentObject(index)
        Rectangle()
            .fill(Color.clear)
            .safeAreaInset(.top) {
                HeaderView(CGPoint(x: 0.0, y: -44.0))
            }
            .environmentObject(index)
            .previewDisplayName("Header View (Scrolled)")
    }
}
