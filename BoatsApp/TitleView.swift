import SwiftUI
import BoatsWeb

struct TitleView: View {
    let title: String?
    
    init(_ title: String? = nil) {
        self.title = title
    }
    
    // MARK: View
    var body: some View {
        if let title {
            HStack {
                Text(title)
                    .font(.system(.title, weight: .semibold))
                    .italic()
                    .foregroundColor(.gold)
                    .shadow()
                Spacer()
            }
            .accessibilityLabel(title)
        }
    }
}

#Preview("Title View") {
    TitleView("Peaks Island")
        .backgroundColor(.haze)
}
