//
// © 2017 @toddheasley
//

import Foundation

public enum Service: String, Codable {
    case car
    case bicycle
    case freight
    case wheelchair
    case dog
    
    public static let all: [Service] = [.car, .bicycle, .freight, .wheelchair, .dog]
}
