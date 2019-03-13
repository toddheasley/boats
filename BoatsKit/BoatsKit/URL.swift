import Foundation

extension URL {
    public init(directory path: String) throws {
        let url: URL = URL(fileURLWithPath: path)
        guard url.hasDirectoryPath,
            FileManager.default.fileExists(atPath: url.path) else {
            throw(NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL))
        }
        self = url
    }
    
    public func delete() throws {
        guard isFileURL else {
            throw(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL))
        }
        guard FileManager.default.fileExists(atPath: path) else {
            return
        }
        try FileManager.default.removeItem(at: self)
    }
}

extension URL {
    static let fetch: URL = URL(string: "https://toddheasley.github.io/boats/index.json")!
    static let build: URL = URL(string: "https://www.cascobaylines.com")!
    
    static func schedule(for route: Route, season: Season.Name) -> URL {
        return URL(string: "\(build.absoluteString)/schedules/\(route.uri)-schedule/\(season.rawValue)")!
    }
}
