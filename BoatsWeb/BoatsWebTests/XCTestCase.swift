//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest

extension XCTestCase {
    enum DataLocation {
        case mock
        case temp
    }
    
    func url(for location: DataLocation, resource: String? = nil, type: String) -> URL? {
        switch location {
        case .mock:
            return Bundle(for: Swift.type(of: self)).url(forResource: resource ?? String(describing: Swift.type(of: self)), withExtension: type)
        case .temp:
            print(NSTemporaryDirectory())
            return URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(resource ?? String(describing: Swift.type(of: self))).\(type)")
        }
    }
    
    func data(for location: DataLocation, resource: String? = nil, type: String) -> Data? {
        guard let url: URL = url(for: location, resource: resource, type: type) else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
}