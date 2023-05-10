import SwiftUI
import Boats

struct ViewCommands: View {
    @EnvironmentObject private var index: ObservableIndex
    
    // MARK: View
    var body: some View {
        Button("Reload Schedules") {
            index.fetch()
        }
        .keyboardShortcut("r", modifiers: .command)
    }
}

struct ViewCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ViewCommands()
            .environmentObject(ObservableIndex())
    }
}
