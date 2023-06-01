import SwiftUI
import Boats

struct MainMenu: View {
    @EnvironmentObject private var index: ObservableIndex
    
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
    
    // MARK: PreviewProvider
    static var previews: some View {
        MainMenu()
            .environmentObject(ObservableIndex())
    }
}
