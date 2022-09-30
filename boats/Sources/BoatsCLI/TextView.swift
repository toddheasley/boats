import Foundation

protocol TextView: CustomStringConvertible {
    var text: [Text] {
        get
    }
}

extension TextView {
    
    // MARK: CustomStringConvertible
    var description: String {
        return text.joined(separator: "\n")
    }
}
