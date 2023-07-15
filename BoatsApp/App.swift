import SwiftUI
import Boats

@main
struct App: SwiftUI.App {
    @State private var index: Index = Index()
    
    private var title: String {
        return ""
    }
    
    // MARK: App
    var body: some Scene {
#if os(iOS)
        WindowGroup(title) {
            Text(title)
        }
#elseif os(watchOS)
        WindowGroup(title) {
            Text(title)
        }
#elseif os(macOS)
        Window(title, id: index.uri) {
            Text(title)
                .environment(index)
                .frame(minWidth: 256.0, minHeight: 256.0)
        }
        .defaultSize(width: 384.0, height: 512.0)
        .windowResizability(.contentMinSize)
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .toolbar) {
                ViewCommands()
                    .environment(index)
            }
            CommandGroup(replacing: .help) {
                HelpCommands()
            }
        }
        /*
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
        } */
#elseif os(tvOS)
        WindowGroup(title) {
            Text(title)
        }
#endif
    }
}
