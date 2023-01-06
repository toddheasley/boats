import SwiftUI
import Boats

struct IndexView: View {
    @EnvironmentObject private var index: IndexObject
    
    // MARK: View
    var body: some View {
        VStack {
            Link(destination: index.url) {
                Text(index.name)
                    .underline()
            }
            Text(index.description)
            TimeView()
        }
        .padding()
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
            .environmentObject(IndexObject())
    }
}
