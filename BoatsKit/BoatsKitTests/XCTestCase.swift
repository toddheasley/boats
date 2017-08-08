//
//  BoatsKit
//  © 2017 @toddheasley
//

import XCTest

extension XCTestCase {
    var url: URL? {
        return Bundle(for: type(of: self)).url(forResource: String(describing: type(of: self)), withExtension: "json")
    }
    
    var data: Data? {
        guard let url = url else {
                return nil
        }
        return try? Data(contentsOf: url)
    }
}
