import SwiftUI

extension Color {
    static var backgroundColor: Self {
        return Self("BackgroundColor")
    }
    
    static var previewColor: Self {
        return secondary.opacity(0.25)
    }
}

struct Color_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        Color.backgroundColor
            .previewDisplayName("Background Color")
        Color.previewColor
            .previewDisplayName("Preview Color")
    }
}
