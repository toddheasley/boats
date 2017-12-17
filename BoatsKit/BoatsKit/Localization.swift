import Foundation

public struct Localization: Codable {
    public var timeZone: TimeZone
    public internal(set) var locale: Locale = Locale(identifier: "en_US")
    
    public init(timeZone: TimeZone = .current) {
        self.timeZone = timeZone
    }
}
