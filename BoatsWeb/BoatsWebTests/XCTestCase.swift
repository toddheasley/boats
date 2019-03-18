import XCTest

extension XCTestCase {
    enum Resource {
        case bundle, temporary
    }
    
    func data(resource: Resource, name: String? = nil, type: String) -> Data? {
        guard let url: URL = url(resource: resource, name: name, type: type) else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
    
    func url(resource: Resource, name: String? = nil, type: String) -> URL? {
        let name: String = name ?? String(describing: Swift.type(of: self))
        switch resource {
        case .bundle:
            return Bundle(for: Swift.type(of: self)).url(forResource: name, withExtension: type)
        case .temporary:
            return URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(name).\(type)")
        }
    }
}
