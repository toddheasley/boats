import Foundation
import Boats

struct TimeView: TextView {
    let time: Time
    
    init(_ time: Time) {
        self.time = time
    }
    
    // MARK: TextView
    var text: [Text] {
        return [
            time.descriptionComponents.map { ($0 != "") ? $0 : " " }.joined()
        ]
    }
}
