import Foundation
import Boats

struct DepartureView: TextView {
    let departure: Departure?
    
    init(_ departure: Departure? = nil) {
        self.departure = departure
    }
    
    // MARK: TextView
    var text: [Text] {
        guard let departure else {
            return []
        }
        var text: [Text] = []
        text.append(TimeView(departure.time).description)
        if departure.isCarFerry {
            text.append("cf")
        }
        for deviation in departure.deviations {
            switch deviation {
            case .except(let day):
                text.append("x\(day.rawValue.first!)")
            case .only(let day):
                text.append("\(day.rawValue.first!)o")
            default:
                break
            }
        }
        return [
            text.joined(separator: " ")
        ]
    }
}
