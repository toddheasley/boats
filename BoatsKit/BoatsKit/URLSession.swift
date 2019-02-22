import Foundation

extension URLSession {
    public enum Action: String, CaseIterable {
        case fetch, build
    }
    
    public func index(action: Action = .fetch, completion: @escaping (Index?, Error?) -> Void) {
        switch action {
        case .fetch:
            fetch(completion: completion)
        case .build:
            build(completion: completion)
        }
    }
}

extension URLSession {
    func fetch(completion: @escaping (Index?, Error?) -> Void) {
        dataTask(with: URL(string: "file:///Users/toddheasley/Documents/Boats/gh-pages/index.json")!) { data, _, error in
            guard let data: Data = data else {
                DispatchQueue.main.async {
                    completion(nil, error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotDecodeContentData, userInfo: nil))
                }
                return
            }
            do {
                let index: Index = try JSONDecoder.shared.decode(Index.self, from: data)
                DispatchQueue.main.async {
                    completion(index, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
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
                    route.append(schedule: schedule)
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
                completion(nil, error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotDecodeContentData, userInfo: nil))
                return
            }
            do {
                completion(try Schedule(from: html), nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
