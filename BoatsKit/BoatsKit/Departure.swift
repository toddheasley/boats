import Foundation

public struct Departure: Codable {
    public private(set) var time: Time
    public private(set) var services: [Service]
    
    public var isCarFerry: Bool {
        return services.contains(.car)
    }
    
    public init(time: Time, services: [Service] = []) {
        self.time = time
        self.services = services
    }
}

extension Departure: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(time.description)\(isCarFerry ? " cf" : "")"
    }
}

extension Departure: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        self.init(time: try Time(from: html.replacingOccurrences(of: "cf", with: "").trim()), services: html.contains("cf") ? [.car] : [])
    }
}
