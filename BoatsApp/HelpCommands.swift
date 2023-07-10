import SwiftUI
import Boats

struct HelpCommands: View {
    static let url: URL = URL(string: "https://github.com/toddheasley/boats")!
    
    // MARK: View
    var body: some View {
        Link("Documentation and Source Code", destination: Self.url)
    }
}

struct HelpCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        HelpCommands()
    }
}
