//
// © 2018 @toddheasley
//

import Foundation

public struct Departure: Codable {
    public enum Direction: String, Codable {
        case destination
        case origin
    }
    
    public var direction: Direction = .destination
    public var time: Time = Time()
    public var days: [Day] = []
    public var services: [Service] = []
    
    public init() {
        
    }
}
