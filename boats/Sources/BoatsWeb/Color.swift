import SwiftUI

extension SwiftUI.Color {
    public static let aqua: Self = Self(.aqua)
    public static let gold: Self = Self(.gold)
    public static let haze: Self = Self(.haze)
    public static let link: Self = Self(.link)
    public static let navy: Self = Self(.navy)
    
    init(_ color: Color) {
        self.init(red: color.red.value, green: color.green.value, blue: color.blue.value, opacity: color.alpha)
    }
}

struct Color_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        HStack {
            VStack {
                SwiftUI.Color.link
                SwiftUI.Color.navy
                SwiftUI.Color.aqua
            }
            VStack {
                SwiftUI.Color.gold
                SwiftUI.Color.haze
                SwiftUI.Color.clear
            }
        }
    }
}

struct Color: Equatable, CustomStringConvertible {
    let red, green, blue: Int
    let alpha: Double
    
    var name: String? {
        switch self {
        case Self(255):
            return "white"
        default:
            return nil
        }
    }
    
    init(_ red: Int, _ green: Int, _ blue: Int, alpha: Double = 1.0) {
        self.red = red.rgbValue
        self.green = green.rgbValue
        self.blue = blue.rgbValue
        self.alpha = min(max(alpha, 0.0), 1.0)
    }
    
    init(_ white: Int, alpha: Double = 1.0) {
        self.init(white, white, white, alpha: alpha)
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        guard alpha < 1.0 else {
            return name ?? "rgb(\(red), \(green), \(blue))"
        }
        return "rgba(\(red), \(green), \(blue), \(round(alpha * 1000.0) / 1000.0))"
    }
}

extension Color: CaseIterable {
    static let aqua: Self = Self(201, 223, 238)
    static let gold: Self = Self(241, 185, 77)
    static let haze: Self = Self(204, alpha: 0.25)
    static let link: Self = Self(44, 103, 212)
    static let navy: Self = Self(32, 61, 83)
    
    // MARK: CaseIterable
    static let allCases: [Self] = [.aqua, .gold, .haze, .link, .navy]
}

private extension Int {
    var rgbValue: Self {
        return Swift.min(Swift.max(self, 0), 255)
    }
    
    var value: Double {
        return round((Double(self) / 255.0) * 1000.0) / 1000.0
    }
}
