//
// © 2018 @toddheasley
//

import Foundation

public struct Location: Codable {
    public var name: String = ""
    public var description: String = ""
    public var coordinate: Coordinate = Coordinate(0.0, 0.0)
    
    public init() {
        
    }
}
