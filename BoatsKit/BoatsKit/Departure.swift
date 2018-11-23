import Foundation

public struct Departure: Codable {
    public private(set) var time: Time
    public private(set) var deviations: [Deviation]
    public private(set) var services: [Service]
    
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
        return "\(time.description) \(string)".trim()
    }
}

extension Departure: HTMLConvertible {
    
    // MARK: HTMLConvertible
    init(from html: String) throws {
        DateFormatter.shared.dateFormat = "M/d"
        let components: [String] = html.trim().components(separatedBy: " ")
        var deviations: [Deviation] = []
        if components.contains("starts"), let date: Date = DateFormatter.shared.date(from: components.last ?? "") {
            deviations.append(.start(date))
        }
        if components.contains("ends"), let date: Date = DateFormatter.shared.date(from: components.last ?? "") {
            deviations.append(.end(date))
        }
        if components.contains("xh") {
            deviations.append(.holiday)
        }
        self.init(time: try Time(from: components[0]), deviations: deviations, services: html.contains("cf") ? [.car] : [])
    }
}
