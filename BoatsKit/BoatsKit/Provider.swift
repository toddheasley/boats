//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct Provider: Codable {
    public var name: String = ""
    public var url: URL?
    public var routes: [Route] = []
}
