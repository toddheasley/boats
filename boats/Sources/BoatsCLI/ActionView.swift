import Foundation
import Boats

struct ActionView: TextView {
    typealias Action = URLSession.Action
    
    let action: Action
    
    init(_ action: Action) {
        self.action = action
    }
    
    // MARK: TextView
    var text: [Text] {
        return [
            "\(action.argument.capitalized) from \(action.url.absoluteString)"
        ]
    }
}
