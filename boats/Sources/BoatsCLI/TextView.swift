protocol TextView: CustomStringConvertible {
    var text: [String] {
        get
    }
}

extension TextView {
    
    // MARK: CustomStringConvertible
    var description: String {
        return text.joined(separator: "\n")
    }
}
