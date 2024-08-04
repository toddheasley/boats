import Foundation

extension URLSession {
    public enum Action: Sendable, Equatable, RawRepresentable, CustomStringConvertible {
        case fetch, build, debug(URL)
        
        public var url: URL {
            switch self {
            case .fetch:
                return .fetch
            case .build:
                return .build
            case .debug(let url):
                return url
            }
        }
        
        public init?(_ string: String) {
            guard let url: URL = .debug(string) else {
                return nil
            }
            self = .debug(url)
        }
        
        // MARK: RawRepresentable
        public var rawValue: String {
            switch self {
            case .fetch:
                return "fetch"
            case .build:
                return "build"
            case .debug(let url):
                return "debug \(url.absoluteString)"
            }
        }
        
        public init?(rawValue: String) {
            let rawValue: [String] = rawValue.components(separatedBy: " ")
            switch rawValue.first {
            case "fetch":
                self = .fetch
            case "build":
                self = .build
            case "debug":
                guard rawValue.count == 2,
                      let url: URL = .debug(rawValue[1]), url.isFileURL else {
                    fallthrough
                }
                self = .debug(url)
            default:
                return nil
            }
        }
        
        // MARK: CustomStringConvertible
        public var description: String { rawValue.components(separatedBy: " ").first! }
    }
    
    public func index(_ action: Action = .fetch) async throws -> Index {
        switch action {
        case .fetch:
            try await debug(url: .fetch)
        case .build:
            try await build()
        case .debug(let url):
            try await debug(url: url)
        }
    }
    
    func build() async throws -> Index {
        var routes: [Route] = []
        for route in Route.allCases {
            let route: Route = try await build(route: route)
            routes.append(route)
        }
        return Index(routes: routes)
        
    }
    
    func build(route: Route) async throws -> Route {
        var route: Route = route
        for season in Season.Name.allCases {
            let schedule: Schedule = try await build(schedule: .schedule(for: route, season: season))
            route.include(schedule: schedule)
        }
        return route
    }
    
    func build(schedule url: URL) async throws -> Schedule {
        let data: Data = try await data(from: url).0
        guard let html: String = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        let schedule: Schedule = try Schedule(from: html)
        return schedule
    }
    
    func debug(url: URL) async throws -> Index {
        func index(from data: Data?) throws -> Index {
            guard let data else {
                throw URLError(.cannotDecodeContentData)
            }
            let index: Index = try JSONDecoder.shared.decode(Index.self, from: data)
            UserDefaults.standard.setValue(data, forKey: "index")
            return index
        }
        
        if url.isFileURL {
            let data: Data = try Data(contentsOf: url)
            let index: Index = try index(from: data)
            return index
        } else {
            let data: Data? = (try? await data(from: url))?.0 ?? UserDefaults.standard.data(forKey: "index")
            let index: Index = try index(from: data)
            return index
        }
    }
}
