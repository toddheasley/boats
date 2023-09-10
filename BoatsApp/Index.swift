import SwiftUI
import Boats

@Observable class Index {
    var name: String { index.name }
    var uri: String { index.uri }
    var location: Location { index.location }
    var routes: [Route] { index.routes }
    var url: URL { index.url }
    var error: Error?
    
    var route: Route? {
        set {
            UserDefaults.standard.set(newValue?.uri, forKey: "route")
            index = nil ?? index
        }
        get {
            let uri: String? = UserDefaults.standard.string(forKey: "route")
            return routes.first { $0.uri == uri } ?? routes.first
        }
    }
    
    func fetch() async {
        error = nil
        do {
            index = try await URLSession.shared.index(.fetch)
        } catch {
            self.error = error
        }
    }
    
    init() {
        Task(priority: .userInitiated) {
            await fetch()
        }
    }
    
    private var index: Boats.Index = Boats.Index()
}
