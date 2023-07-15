import SwiftUI
import Boats

struct ViewCommands: View {
    @Environment(Index.self) private var index: Index
    
    // MARK: View
    var body: some View {
        Button("Reload Schedules") {
            Task {
                await index.fetch()
            }
        }
        .keyboardShortcut("r", modifiers: .command)
    }
}

struct ViewCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ViewCommands()
            .environment(Index())
    }
}
