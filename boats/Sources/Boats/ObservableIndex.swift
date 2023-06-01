import Foundation

@MainActor
public class ObservableIndex: ObservableObject {
    @Published public private(set) var name: String
    @Published public private(set) var description: String
    @Published public private(set) var uri: String
    @Published public private(set) var location: Location
    @Published public private(set) var routes: [Route]
    @Published public private(set) var url: URL
    @Published public var error: Error?
    
    @Published public var route: Route? {
        didSet {
            if route == nil, !routes.isEmpty {
                route = routes.first!
            } else {
                UserDefaults.standard.set(route?.uri, forKey: "route")
            }
        }
    }
    
    public func route(uri: String?) -> Route? {
        return routes.first { $0.uri == uri }
    }
    
    public func fetch() async {
        error = nil
        do {
            let index: Index = try await URLSession.shared.index()
            self.name = index.name
            self.description = index.description
            self.uri = index.uri
            self.location = index.location
            self.routes = index.routes
            self.url = index.url
            route = route(uri: UserDefaults.standard.string(forKey: "route")) ?? index.routes.first
        } catch {
            self.error = error
        }
    }
    
    required public init(_ index: Index = Index()) {
        name = index.name
        description = index.description
        uri = index.uri
        location = index.location
        routes = index.routes
        url = index.url
        Task {
            await fetch()
        }
    }
}
