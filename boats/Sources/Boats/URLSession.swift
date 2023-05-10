import Foundation

extension URLSession {
    public enum Action: Equatable, RawRepresentable, CustomStringConvertible {
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
        public var description: String {
            return rawValue.components(separatedBy: " ").first!
        }
    }
    
    public func index(_ action: Action = .fetch) async throws -> Index {
        try await withCheckedThrowingContinuation { continuation in
            index(action) { index, error in
                if let index {
                    continuation.resume(returning: index)
                } else {
                    continuation.resume(throwing: error ?? URLError(.unsupportedURL))
                }
            }
        }
    }
    
    func index(_ action: Action, completion: @escaping (Index?, Error?) -> Void) {
        switch action {
        case .fetch:
            fetch(completion: completion)
        case .build:
            build(completion: completion)
        case .debug(let url):
            debug(url: url, completion: completion)
        }
    }
    
    func fetch(completion: @escaping (Index?, Error?) -> Void) {
        debug(url: .fetch, completion: completion)
    }
    
    func build(completion: @escaping (Index?, Error?) -> Void) {
        build { routes, error in
            DispatchQueue.main.async {
                completion(Index(routes: routes), error)
            }
        }
    }
    
    func build(routes: [Route] = [], from index: Int = 0, completion: @escaping ([Route], Error?) -> Void) {
        guard index < Route.allCases.count else {
            completion(routes, nil)
            return
        }
        var routes: [Route] = routes
        build(route: Route.allCases[index]) { route, _ in
            routes.append(route)
            self.build(routes: routes, from: index + 1, completion: completion)
        }
    }
    
    func build(route: Route, completion: @escaping (Route, [Error]) -> Void) {
        var route: Route = route
        var errors: [Error] = []
        var queue: Int = Season.Name.allCases.count
        for season in Season.Name.allCases {
            build(schedule: .schedule(for: route, season: season)) { schedule, error in
                queue -= 1
                if let schedule: Schedule = schedule {
                    route.include(schedule: schedule)
                }
                if let error: Error = error {
                    errors.append(error)
                }
                if queue < 1 {
                    completion(route, errors)
                }
            }
        }
    }
    
    func build(schedule url: URL, completion: @escaping (Schedule?, Error?) -> Void) {
        dataTask(with: url) { data, _, error in
            guard let data: Data = data,
                let html: String = String(data: data, encoding: .utf8) else {
                completion(nil, error ?? URLError(.cannotDecodeContentData))
                return
            }
            do {
                completion(try Schedule(from: html), nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func debug(url: URL, completion: @escaping (Index?, Error?) -> Void) {
        func handle(data: Data?, error: Error?, completion: @escaping (Index?, Error?) -> Void) {
            guard let data: Data = data else {
                completion(nil, error ?? URLError(.cannotDecodeContentData))
                return
            }
            do {
                let index: Index = try JSONDecoder.shared.decode(Index.self, from: data)
                UserDefaults.standard.setValue(data, forKey: "index")
                completion(index, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        if url.isFileURL {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                do {
                    let data: Data = try Data(contentsOf: url)
                    handle(data: data, error: nil, completion: completion)
                } catch {
                    handle(data: nil, error: error, completion: completion)
                }
            }
        } else {
            dataTask(with: url) { data, _, error in
                let data: Data? = data ?? UserDefaults.standard.data(forKey: "index")
                DispatchQueue.main.async {
                    handle(data: data, error: error, completion: completion)
                }
            }.resume()
        }
    }
}
