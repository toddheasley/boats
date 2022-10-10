import Foundation

public protocol StringConvertible: CustomStringConvertible {
    func description(_ format: String.Format) -> String
}

extension StringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        return description(.sentence)
    }
}
