//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct Schedule: Codable {
    public var season: Season = .evergreen
    public var holidays: [Holiday] = []
    public var departures: [Departure] = []
}
