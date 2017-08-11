//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct Route: Codable {
    public var name: String = ""
    public var destination: Location = Location()
    public var origin: Location = Location()
    public var schedules: [Schedule] = []
}
