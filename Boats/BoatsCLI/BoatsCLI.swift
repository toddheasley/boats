import Foundation
import ArgumentParser
import BoatsKit
import BoatsWeb

struct BoatsCLI: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(abstract: Bundle.main.executableName)
    
    @Argument(help: "Actions: [\(URLSession.Action.allCases.map { $0.rawValue }.joined(separator: ", "))]")
    var action: URLSession.Action
    
    @Flag(name: .shortAndLong, help: "Generate static web files.")
    var web: Bool
    
    private func print(result: String, discussion: [String] = []) {
        var result: String = "RESULT: \(Bundle.main.executableName) \(action.rawValue) \(result)"
        if !discussion.isEmpty {
            result += "\n\n\(discussion.joined(separator: "\n"))\n"
        }
        Swift.print(result)
    }
    
    // MARK: ParsableCommand
    func run() throws {
        let runLoop: CFRunLoop = CFRunLoopGetCurrent()
        URLSession.shared.index(action: action) { index, error in
            CFRunLoopStop(runLoop)
            do {
                guard let index: Index = index else {
                    throw(error ?? NSError(domain: "", code: 0, userInfo: nil))
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
                self.print(result: "completed", discussion: discussion)
            } catch {
                self.print(result: "failed", discussion: ["ERROR: \(error)"])
            }
        }
        CFRunLoopRun()
    }
}

extension URLSession.Action: ExpressibleByArgument {
    
}
