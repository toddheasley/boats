import SwiftUI
import Boats

@main
struct App: SwiftUI.App {
    @StateObject private var index: ObservableIndex = ObservableIndex()
    
    // MARK: App
    var body: some Scene {
        WindowGroup {
            IndexView()
#if os(macOS)
                .frame(minWidth: 360.0, minHeight: 270.0)
#endif
                .environmentObject(index)
        }
#if os(macOS)
        .defaultSize(width: 360.0, height: 540.0)
        .windowResizability(.contentMinSize)
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .toolbar) {
                ViewCommands()
                    .environmentObject(index)
            }
            CommandGroup(replacing: .help) {
                HelpCommands()
            }
        }
#endif
    }
}
