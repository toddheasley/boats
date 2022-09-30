import Foundation

typealias Text = String

extension Text {
    enum Pad: String, CaseIterable {
        case right, left
    }
    
    func padded(_ pad: Pad = .right, to length: Int, with character: Character = " ") -> Self {
        let length: Int = length - count
        guard length > 0 else {
            return self
        }
        let string: Self = Self(repeating: character, count: length)
        return padded(pad, with: string)
    }
    
    func padded(_ pad: Pad = .right, with string: Self) -> Self {
        switch pad {
        case .right:
            return "\(self)\(string)"
        case .left:
            return "\(string)\(self)"
        }
    }
}
