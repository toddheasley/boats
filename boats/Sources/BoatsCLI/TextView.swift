protocol TextView: CustomStringConvertible {
    var text: [String] { get }
}

extension TextView {
    
    // MARK: CustomStringConvertible
    var description: String { text.joined(separator: "\n") }
}
