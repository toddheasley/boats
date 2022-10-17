import SwiftUI
import Boats

struct IndexView: View {
    @EnvironmentObject private var index: IndexObject
    
    // MARK: View
    var body: some View {
        VStack {
            Text(index.name)
            Text(index.description)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
            .environmentObject(IndexObject())
    }
}
