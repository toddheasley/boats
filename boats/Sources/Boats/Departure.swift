import Foundation

public struct Departure: Sendable, Codable, CustomAccessibilityStringConvertible {
    public let time: Time
    public let deviations: [Deviation]
    public let services: [Service]
    
    public var isCarFerry: Bool { services.contains(.car) }
    
    public func components(empty string: String? = "") -> [String] {
        [
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
    
    // MARK: CustomAccessibilityStringConvertible
    public var accessibilityDescription: String {
        [
            time.accessibilityDescription,
            (isCarFerry ? Service.car.description : ""),
            deviations.accessibilityDescription
        ].compactMap { !$0.isEmpty ? $0 : nil }.joined(separator: " ")
    }
    
    public var description: String { components(empty: nil).joined(separator: " ") }
}

extension Departure: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        let components: [String] = html.lowercased().trim().components(separatedBy: " ")
        var deviations: [Deviation] = []
        if components.contains("fso") || components.contains("⁕") {
            deviations += [.only(.friday), .only(.saturday)]
        }
        if components.contains("fo") {
            deviations.append(.only(.friday))
        }
        if components.contains("xf") {
            deviations.append(.except(.friday))
        }
        self.init(try Time(from: components[0]), deviations: deviations, services: html.contains("cf") ? [.car] : [])
    }
}
