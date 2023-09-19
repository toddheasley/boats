import Foundation

extension Bundle {
    func data(forResource name: String?, withExtension ext: String? = nil) throws -> Data {
        let url: URL = try url(forResource: name, withExtension: ext)
        return try Data(contentsOf: url)
    }
    
    func url(forResource name: String?, withExtension ext: String? = nil) throws -> URL {
        guard let url: URL = url(forResource: name, withExtension: ext) else {
            throw URLError(.badURL)
        }
        return url
    }
}
