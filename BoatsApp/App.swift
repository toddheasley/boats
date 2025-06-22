import SwiftUI
import BoatsWeb
import Boats

@main
struct App: SwiftUI.App {
    @State private var index: Index = Index()
    
    private var title: String {
        return index.route?.description ?? Bundle.main.executableURL?.lastPathComponent ?? ""
    }
    
    // MARK: App
    var body: some Scene {
#if os(macOS)
        Window(title, id: index.uri) {
            IndexView()
                .environment(index)
                .frame(minWidth: 320.0, minHeight: .maxWidth)
                .ignoresSafeArea()
        }
        .defaultSize(width: .maxWidth, height: 512.0)
        .windowResizability(.contentMinSize)
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .toolbar) {
                Button("Reload Schedules") {
                    Task { await index.fetch() }
                }
                .keyboardShortcut("r", modifiers: .command)
            }
            CommandGroup(replacing: .help) {
                Link("GitHub Repository", destination: Site.repoURL)
                Link("Web Schedules", destination: Site.baseURL)
            }
        }
#else
        WindowGroup(title) {
            IndexView()
                .environment(index)
        }
#endif
    }
}
