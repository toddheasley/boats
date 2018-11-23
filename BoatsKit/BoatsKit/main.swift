import Foundation

let name: String = Bundle.main.executableURL!.lastPathComponent

var isDirectory: ObjCBool = false
guard CommandLine.arguments.count == 3,
    let action: URLSession.Action = URLSession.Action(rawValue: CommandLine.arguments[1]),
    FileManager.default.fileExists(atPath: CommandLine.arguments[2], isDirectory: &isDirectory), isDirectory.boolValue else {
    print("\(name) [bad argument(s)]")
    exit(1)
}

let runLoop: CFRunLoop = CFRunLoopGetCurrent()
URLSession.shared.index(action: action) { index, error in
    guard let index: Index = index else {
        print("\(name) [failed: \(error?.localizedDescription ?? "")]")
        exit(1)
    }
    do {
        let data: Data = try JSONEncoder.shared.encode(index)
        try data.write(to: URL(fileURLWithPath: "\(CommandLine.arguments[2])/Index.json"))
        exit(0)
    } catch {
        print("\(name) [\(error)]")
        exit(1)
    }
    CFRunLoopStop(runLoop)
}
CFRunLoopRun()
