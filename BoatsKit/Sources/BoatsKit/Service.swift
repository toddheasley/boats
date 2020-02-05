import Foundation

public enum Service: String, Codable, CaseIterable {
    case car, bicycle, freight, wheelchair, dog
}

extension Service: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        return rawValue
    }
}
