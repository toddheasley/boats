import Foundation

public struct Departure: Codable, CustomStringConvertible {
    public let time: Time
    public let deviations: [Deviation]
    public let services: [Service]
    
    public var isCarFerry: Bool {
        return services.contains(.car)
    }
    
    public func components(empty string: String? = "") -> [String] {
        return [
            time.description,
            (isCarFerry ? Service.car.description : ""),
            deviations.description
        ].compactMap { !$0.isEmpty ? $0 : string }
    }
    
    public init(_ time: Time, deviations: [Deviation] = [], services: [Service] = []) {
        self.time = time
        self.deviations = deviations
        self.services = services
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return components(empty: nil).joined(separator: " ")
    }
}

extension Departure: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        let components: [String] = html.lowercased().trim().components(separatedBy: " ")
        
        var deviations: [Deviation] = []
        if components.contains("⁕") {
            deviations += [.only(.friday), .only(.saturday)]
        }
        if components.contains("∆") {
            deviations += Day.weekdays.map { .only($0) }
        }
        self.init(try Time(from: components[0]), deviations: deviations, services: html.contains("cf") ? [.car] : [])
    }
}
