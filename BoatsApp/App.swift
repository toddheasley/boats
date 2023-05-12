import SwiftUI
import Boats

@main
struct App: SwiftUI.App {
    @StateObject private var index: ObservableIndex = ObservableIndex()
    
    private var title: String {
        return index.route?.description ?? index.description
    }
    
    // MARK: App
    var body: some Scene {
#if os(iOS) || os(watchOS)
        WindowGroup(title) {
            IndexView()
                .environmentObject(index)
        }
#elseif os(macOS)
        MenuBarExtra(content: {
            VStack {
                ForEach(index.routes) { route in
                    Text("\(route.description)")
                }
                Divider()
                Button("Quit Boats") {
                    NSApplication.shared.terminate(nil)
                }
                .keyboardShortcut("q")
            }
        }) {
            Text("Boats")
        }
        /*
        WindowGroup(title) {
            IndexView()
                .frame(minWidth: 360.0, minHeight: 270.0)
                .environmentObject(index)
        }
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
        } */
#elseif os(tvOS)
        WindowGroup(title) {
            Text(title)
        }
#endif
    }
}
