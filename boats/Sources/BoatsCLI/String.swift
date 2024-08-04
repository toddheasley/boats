extension String {
    func padded(to count: Int, with character: Character = " ") -> Self {
        count > self.count ? "\(self)\(Self(repeating: character, count: count - self.count))" : truncated(to: count)
    }
    
    private func truncated(to count: Int, with character: Character = "…") -> Self {
        self.count > count ? "\(prefix(count - 1))\(character)" : self
    }
}
