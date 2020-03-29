import Foundation
import ArgumentParser
import BoatsKit
import BoatsWeb

struct BoatsCLI: ParsableCommand {
    @Argument(help: "Specify an action: \(URLSession.Action.allCases.map { $0.rawValue.components(separatedBy: " ")[0] }.joined(separator: ", "))")
    var action: URLSession.Action
    
    @Flag(name: .shortAndLong, help: "Generate static web files.")
    var web: Bool
    
    // MARK: ParsableCommand
    static var configuration: CommandConfiguration = CommandConfiguration(abstract: "Update Boats schedules.")
    
    func run() throws {
        let runLoop: CFRunLoop = CFRunLoopGetCurrent()
        defer {
            CFRunLoopRun()
        }
        URLSession.shared.index(action: action) { index, error in
            CFRunLoopStop(runLoop)
            do {
                guard let index: Index = index else {
                    throw(error ?? URLError(.badURL))
                }
                try index.build(to: Bundle.main.bundleURL)
                try? Site(index: index).delete(from: Bundle.main.bundleURL)
                if self.web {
                    try Site(index: index).build(to: Bundle.main.bundleURL)
                }
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
                print(discussion.joined(separator: "\n"))
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
}

extension URLSession.Action: ExpressibleByArgument {
    
    // MARK: ExpressibleByArgument
    public init?(argument: String) {
        guard let action: Self = Self(rawValue: "\(argument) \(Bundle.main.bundlePath)") ?? Self(rawValue: argument) else {
            return nil
        }
        self = action
    }
}
