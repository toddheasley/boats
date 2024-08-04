import Cocoa
import ArgumentParser
import Boats
import BoatsWeb

@main
struct Main: AsyncParsableCommand {
    @Argument(help: "Specify an action: fetch, build, debug")
    var action: URLSession.Action = .fetch
    
    @Flag(name: .shortAndLong, help: "Generate static web files.")
    var web: Bool = false
    
    // MARK: ParsableCommand
    nonisolated(unsafe) static var configuration: CommandConfiguration = CommandConfiguration(abstract: "Update Boats schedules.")
    
    func run() async throws {
        let index: Index = try await URLSession.shared.index(action)
        print("\(action.argument.capitalized) from \(action.url.absoluteString)")
        try index.build(to: Bundle.main.bundleURL)
        NSWorkspace.shared.open(Bundle.main.bundleURL)
        try? Site(index).delete(from: Bundle.main.bundleURL)
        if web {
            let site: Site = Site(index)
            try site.build(to: Bundle.main.bundleURL)
            NSWorkspace.shared.open(Bundle.main.bundleURL.appendingPathComponent(site.path))
        }
        print(IndexView(index))
    }
}
