import Boats

extension Service {
    public var emoji: String {
        switch self {
        case .car: "🚙"
        case .bicycle: "🚲"
        case .freight: "📦"
        case .wheelchair: "🦽"
        case .dog: "🦮"
        }
    }
}
