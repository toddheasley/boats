import SwiftUI

extension Color {
    static var background: Self {
        return Self("BackgroundColor")
    }
    
    static var preview: Self {
        return secondary.opacity(0.25)
    }
}

struct Color_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        Color.background
            .previewDisplayName("Background Color")
        Color.preview
            .previewDisplayName("Preview Color")
    }
}
