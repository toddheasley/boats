public enum Service: String, Codable, CaseIterable, StringConvertible {
    case car, bicycle, freight, wheelchair, dog
    
    // MARK: StringConvertible
    public func description(_ format: String.Format) -> String {
        switch format {
        case .compact:
            switch self {
            case .car:
                return "cf"
            case.bicycle:
                return "bike"
            default:
                return rawValue
            }
        default:
            return rawValue
        }
    }
}
