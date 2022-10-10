typealias Text = String

extension Text {
    func padded(to count: Int, with character: Character = " ") -> Self {
        guard count > self.count else {
            return truncated(to: count)
        }
        return "\(self)\(Self(repeating: character, count: count - self.count))"
    }
    
    private func truncated(to count: Int, with character: Character = "…") -> Self {
        guard self.count > count else {
            return self
        }
        return "\(prefix(count - 1))\(character)"
    }
}
