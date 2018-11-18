import Foundation

extension DateFormatter {
    enum ClockFormat {
        case twelveHour, twentyFourHour, auto
    }
    
    static let shared: DateFormatter = DateFormatter(timeZone: .shared)
    static var clockFormat: ClockFormat = .auto
    
    var is24Hour: Bool {
        switch DateFormatter.clockFormat {
        case .twelveHour:
            return false
        case .twentyFourHour:
            return true
        case .auto:
            dateStyle = .none
            timeStyle = .medium
            return !string(from: Date()).contains(" ")
        }
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
