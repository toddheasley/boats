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
        text.append(departure.time.components(empty: " ").joined())
        if departure.isCarFerry {
            text.append("cf")
        }
        for deviation in departure.deviations {
            text.append(deviation.description(.compact))
        }
        return [
            text.joined(separator: " ")
        ]
    }
}
