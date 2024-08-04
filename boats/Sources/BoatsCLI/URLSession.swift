import Foundation
import ArgumentParser
import Boats

extension URLSession.Action: @retroactive ExpressibleByArgument {
    var argument: String { rawValue.components(separatedBy: " ").first! }
    
    // MARK: ExpressibleByArgument
    public init?(argument: String) {
        guard let action: Self = Self(rawValue: "\(argument) \(Bundle.main.bundlePath)") ?? Self(rawValue: argument) else {
            return nil
        }
        self = action
    }
}
