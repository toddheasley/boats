import SwiftUI
import Boats

@main
struct App: SwiftUI.App {
    @StateObject private var index: IndexObject = IndexObject()
    
    var body: some Scene {
        WindowGroup {
            IndexView()
#if os(macOS)
                .frame(minWidth: 270.0, minHeight: 90.0)
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
