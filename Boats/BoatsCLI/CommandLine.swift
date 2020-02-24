import Foundation
import BoatsKit

extension CommandLine {
    enum Status {
        case help, fail(Error?), done
    }
    
    static var action: URLSession.Action? {
        guard arguments.count > 1 else {
            return nil
        }
        return URLSession.Action(rawValue: arguments[1])
    }
    
    static var web: Bool {
        return arguments.contains("-web")
    }
    
    static func print(_ status: Status) {
        var string: String = "\(Bundle.main.executableName)"
        if let action: URLSession.Action = action {
            string += " \(action.rawValue)"
        }
        switch status {
        case .help:
            string += " help:\n"
            string += "    \n"
            for action in URLSession.Action.allCases {
                string += "    [action] \(action.rawValue)\n"
            }
            string += "    [flag] -web\n"
            string += "    "
        case .fail(let error):
            string += " failed: \(error?.localizedDescription.lowercased() ?? "unknown reason")"
        case .done:
            string += " succeeded"
        }
        Swift.print(string)
    }
}
