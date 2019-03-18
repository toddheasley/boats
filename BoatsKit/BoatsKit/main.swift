import Foundation

let name: String = Bundle.main.executableURL!.lastPathComponent

func description(of error: Error?) -> String {
    return error?.localizedDescription.lowercased() ?? "?"
}

guard CommandLine.arguments.count > 2,
    let action: URLSession.Action = URLSession.Action(rawValue: CommandLine.arguments[1]),
    let url: URL = try? URL(directory: CommandLine.arguments[2]) else {
    print("\(name) (fetch|build) \"/path/to/directory/\"")
    exit(1)
}
let runLoop: CFRunLoop = CFRunLoopGetCurrent()
URLSession.shared.index(action: action) { index, error in
    guard let index: Index = index else {
        print("\(name) \(action.rawValue) failed: \(description(of: error))")
        exit(1)
    }
    do {
        try index.build(to: url)
        print("\(name) \(action.rawValue) completed")
        exit(0)
    } catch {
        print("\(name) \(action.rawValue) failed: \(description(of: error))")
        exit(1)
    }
    CFRunLoopStop(runLoop)
}
CFRunLoopRun()
