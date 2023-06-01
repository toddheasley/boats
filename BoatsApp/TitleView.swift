import SwiftUI

struct TitleView: View {
    init(_ title: String? = nil) {
        self.title = title
    }
    
    private let title: String?
    
    // MARK: View
    var body: some View {
        HStack {
            Text(title ?? " ")
                .lineLimit(1)
                .font(.title)
            Spacer()
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        TitleView("Chebeague Island")
            .background(Color.preview)
            .padding()
        TitleView()
            .background(Color.preview)
            .padding()
            .previewDisplayName("Title View (Empty)")
    }
}
