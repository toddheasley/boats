import SwiftUI
import Boats

struct IndexMenu: View {
    @EnvironmentObject private var index: IndexObject
    
    // MARK: View
    var body: some View {
        Menu {
            ForEach(index.routes) { route in
                Button(action: {
                    index.route = route
                }) {
                    Text(route.location.name)
                }
            }
        } label: {
            Label("Routes", systemImage: "ellipsis.circle.fill")
                .labelStyle(.iconOnly)
        }
    }
}

struct IndexMeniu_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
            .environmentObject(IndexObject())
    }
}
