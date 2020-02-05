import Foundation
import BoatsKit
import BoatsWeb

guard let action: URLSession.Action = CommandLine.action else {
    CommandLine.print(.help)
    exit(0)
}
let runLoop: CFRunLoop = CFRunLoopGetCurrent()
URLSession.shared.index(action: action) { index, error in
    CFRunLoopStop(runLoop)
    guard let index: Index = index else {
        CommandLine.print(.fail(error))
        exit(1)
    }
    do {
        try index.build(to: Bundle.main.bundleURL)
        try? Site(index: index).delete(from: Bundle.main.bundleURL)
        if CommandLine.web {
            try Site(index: index).build(to: Bundle.main.bundleURL)
        }
        CommandLine.print(.done)
        exit(0)
    } catch {
        CommandLine.print(.fail(error))
        exit(1)
    }
}
CFRunLoopRun()
