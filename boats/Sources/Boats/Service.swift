public enum Service: String, Codable, CaseIterable, CustomStringConvertible {
    case car, bicycle, freight, wheelchair, dog
    
    // MARK: CustomStringConvertible
    public var description: String {
        return rawValue
    }
}
