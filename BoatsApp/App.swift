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
        WindowGroup(title) {
            Text(title)
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
        /*
        WindowGroup(title) {
            Text(title)
                .frame(minWidth: 360.0, minHeight: 270.0)
                //.environmentObject(index)
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
