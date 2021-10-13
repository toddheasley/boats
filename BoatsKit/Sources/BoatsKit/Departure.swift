import Foundation

public struct Departure: Codable {
    public let time: Time
    public let deviations: [Deviation]
    public let services: [Service]
    
    public var isCarFerry: Bool {
        return services.contains(.car)
    }
    
    public init(time: Time, deviations: [Deviation] = [], services: [Service] = []) {
        self.time = time
        self.deviations = deviations
        self.services = services
    }
}

extension Departure: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        let string: String = (deviations.map { deviation in
            return deviation.description
        } + services.map { service in
            return service.description
        }).joined(separator: ", ")
        return "\(time) \(string)".trim()
    }
}

extension Departure: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        var html: String = html.lowercased()
        html = html.replacingOccurrences(of: "(", with: "")
        html = html.replacingOccurrences(of: ")", with: "")
        html = html.replacingOccurrences(of: "sat only", with: "so")
        html = html.replacingOccurrences(of: "**", with: "")
        html = html.replacingOccurrences(of: "*", with: "")
        let components: [String] = html.trim().components(separatedBy: " ")
        var deviations: [Deviation] = []
        if components.contains("starts"), let date: Date = DateFormatter.shared.date(html: components.last) {
            deviations.append(.start(date))
        }
        if components.contains("ends"), let date: Date = DateFormatter.shared.date(html: components.last) {
            deviations.append(.end(date))
        }
        if components.contains("xh") {
            deviations.append(.except(.holiday))
        }
        if components.contains("xf") {
            deviations.append(.except(.friday))
        }
        if components.contains("fo") {
            deviations.append(.only(.friday))
        }
        if components.contains("so") {
            deviations.append(.only(.saturday))
        }
        self.init(time: try Time(from: components[0]), deviations: deviations, services: html.contains("cf") ? [.car] : [])
    }
}
