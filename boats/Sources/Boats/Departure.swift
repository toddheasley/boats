import Foundation

public struct Departure: Codable, CustomStringConvertible {
    public let time: Time
    public let deviations: [Deviation]
    public let services: [Service]
    
    public var isCarFerry: Bool {
        return services.contains(.car)
    }
    
    public init(_ time: Time, deviations: [Deviation] = [], services: [Service] = []) {
        self.time = time
        self.deviations = deviations
        self.services = services
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        var description: [String] = [
            time.description
        ]
        if isCarFerry {
            description.append(Service.car.description)
        }
        if !deviations.isEmpty {
            description.append(deviations.description)
        }
        return description.joined(separator: " ")
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
