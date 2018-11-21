import Foundation

extension URLSession {
    public enum Action {
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
        dataTask(with: URL(string: "https://toddheasley.github.io/boats/index.json")!) { data, response, error in
            guard let data: Data = data else {
                DispatchQueue.main.async {
                    completion(nil, error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotDecodeContentData, userInfo: nil))
                }
                return
            }
            do {
                let index: Index = try JSONDecoder().decode(Index.self, from: data)
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
        DispatchQueue.main.async {
            completion(nil, nil)
        }
    }
}
