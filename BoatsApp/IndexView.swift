import SwiftUI
import Boats

struct IndexView: View {
    @EnvironmentObject private var index: ObservableIndex
    @State private var offset: CGPoint = .zero
    
    // MARK: View
    var body: some View {
        ScrollView(onScroll: { offset in
            self.offset = offset
        }) {
            VStack {
                Spacer(minLength: 256.0)
                Text(index.route?.description ?? index.description)
                Spacer(minLength: 2048.0)
            }
        }
        .onChange(of: offset) { offset in
            print(offset.y)
        }
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
            .environmentObject(ObservableIndex())
    }
}
