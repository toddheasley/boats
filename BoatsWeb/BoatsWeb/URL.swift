import Foundation

extension URL {
    static func bundle(resource name: String, type: String) throws -> URL {
        guard let url: URL = Bundle(for: Swift.type(of: URLClass())).url(forResource: name, withExtension: type) else {
            throw(NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL))
        }
        return url
    }
    
    private class URLClass {
        
    }
}
