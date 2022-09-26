import Foundation
import ArgumentParser
import Boats
import BoatsWeb

@main
struct Interface: AsyncParsableCommand {
    @Argument(help: "Specify an action: fetch, build, debug")
    var action: URLSession.Action = .fetch
        
    @Flag(name: .shortAndLong, help: "Generate static web files.")
    var web: Bool = false
    
    // MARK: ParsableCommand
    static var configuration: CommandConfiguration = CommandConfiguration(abstract: "Update Boats schedules.")
    
    func run() async throws {
        let index: Index = try await URLSession.shared.index(action)
        try index.build(to: Bundle.main.bundleURL)
        try? Site(index).delete(from: Bundle.main.bundleURL)
        if web {
            try Site(index).build(to: Bundle.main.bundleURL)
        }
        
        /*
        var discussion: [String] = []
        discussion.append("SCHEDULES:")
        for route in index.routes {
            discussion.append("  \(route.uri) ")
            for schedule in route.schedules {
                discussion.append("  - \(schedule.season.description.lowercased())")
            }
            discussion.append("")
        }
        discussion.append("WEB: \(self.web ? "Files generated." : "Files not generated.")")
        discussion.append("")
        print(discussion.joined(separator: "\n")) */
        
    }
}
