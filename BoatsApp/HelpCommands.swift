import SwiftUI
import Boats
import BoatsWeb

struct HelpCommands: View {
    
    // MARK: View
    var body: some View {
        Link("GitHub Repository", destination: Site.repoURL)
        Link("Web Schedules", destination: Site.baseURL)
    }
}

struct HelpCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        HelpCommands()
    }
}
