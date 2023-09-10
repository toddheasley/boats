import SwiftUI
import BoatsWeb

extension Text {
    func head() -> some View {
        return font(.head)
            .italic()
            .foregroundColor(.gold)
            .shadow()
    }
    
    func tiny() -> some View {
        return textCase(.uppercase)
            .font(.tiny)
    }
}


#Preview("Head Text") {
    Text("Peaks Island")
        .head()
}

#Preview("Tiny Text") {
    Text("Depart Peaks")
        .tiny()
}
