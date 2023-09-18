import SwiftUI
import Boats

@Observable class Index: CustomStringConvertible {
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
            index.cache()
        } catch {
            self.error = error
        }
    }
    
    init() {
        index = Boats.Index(nil) ?? index
        Task {
            await fetch()
        }
    }
    
    private var index: Boats.Index = Boats.Index()
    
    // MARK: CustomStringConvertible
    public var description: String { index.description }
}

private extension Boats.Index {
    func cache() {
        guard let cache: Cache = Cache(self),
            let data: Data = try? JSONEncoder().encode(cache) else {
            return
        }
        UserDefaults.standard.set(data, forKey: "cache")
    }
    
    init?(_ cached: TimeInterval?) {
        guard let data: Data = UserDefaults.standard.data(forKey: "cache"),
              let cache: Cache = try? JSONDecoder().decode(Cache.self, from: data),
              let index: Boats.Index = cache.index(cached) else {
            return nil
        }
        self = index
    }
    
    private struct Cache: Codable {
        typealias Index = Boats.Index
        let date: Date
        
        func index(_ cached: TimeInterval? = nil) -> Index? {
            guard let index: Index = try? Index(data: data),
                  cached == nil || Date() < Date(timeInterval: cached!, since: date) else {
                return nil
            }
            return index
        }
        
        init?(_ index: Boats.Index) {
            guard let data: Data = try? index.data() else {
                return nil
            }
            self.date = Date()
            self.data = data
        }
        
        private let data: Data
    }
}
