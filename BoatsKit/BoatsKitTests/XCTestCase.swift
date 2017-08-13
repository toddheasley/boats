//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest

extension XCTestCase {
    var data: Data? {
        guard let url: URL = url else {
                return nil
        }
        return try? Data(contentsOf: url)
    }
    
    var url: URL? {
        return Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "json")
    }
}
