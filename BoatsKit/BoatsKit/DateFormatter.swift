import Foundation

extension DateFormatter {
    static let shared: DateFormatter = DateFormatter(timeZone: .shared)
    
    var is24Hour: Bool {
        dateStyle = .none
        timeStyle = .medium
        return !string(from: Date()).contains(" ")
    }
    
    func time(from date: Date) -> Time {
        dateFormat = "H:m"
        let components: [String] = string(from: date).components(separatedBy: ":")
        return Time(hour: Int(components[0])!, minute: Int(components[1])!)
    }
    
    convenience init(timeZone: TimeZone) {
        self.init()
        self.timeZone = timeZone
    }
}
