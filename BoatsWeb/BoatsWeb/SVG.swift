//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

enum SVG: String {
    case menu = "Menu"
}

extension SVG: DataEncoding {
    private class SVGClass {
        
    }
    
    func data() throws -> Data {
        guard let url: URL = Bundle(for: type(of: SVGClass())).url(forResource: "\(rawValue)", withExtension: "svg") else {
            throw NSError(domain: NSURLErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        return try Data(contentsOf: url)
    }
}
