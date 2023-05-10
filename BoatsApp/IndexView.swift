import SwiftUI
import Boats

struct IndexView: View {
    @EnvironmentObject private var index: ObservableIndex
    
    // MARK: View
    var body: some View {
        ZStack(alignment: .top) {
            // IndexMenu()
            VStack {
                Spacer()
                Text(index.route?.description ?? index.description)
                Spacer()
            }
        }
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
            .environmentObject(ObservableIndex())
    }
}
