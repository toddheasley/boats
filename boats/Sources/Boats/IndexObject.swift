import Foundation

@MainActor
public class IndexObject: ObservableObject {
    @Published public private(set) var name: String
    @Published public private(set) var description: String
    @Published public private(set) var uri: String
    @Published public private(set) var location: Location
    @Published public private(set) var routes: [Route]
    @Published public private(set) var url: URL
    @Published public var error: Error?
    
    public func fetch() {
        error = nil
        Task {
            do {
                let index: Index = try await URLSession.shared.index()
                self.name = index.name
                self.description = index.description
                self.uri = index.uri
                self.location = index.location
                self.routes = index.routes
                self.url = index.url
            } catch {
                self.error = error
            }
        }
    }
    
    required public init(_ index: Index = Index()) {
        name = index.name
        description = index.description
        uri = index.uri
        location = index.location
        routes = index.routes
        url = index.url
        fetch()
    }
}
