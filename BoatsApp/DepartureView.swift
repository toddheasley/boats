import SwiftUI
import Boats

struct DepartureView: View {
    let departure: Departure
    
    init(_ departure: Departure) {
        self.departure = departure
    }
    
    // MARK: View
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            TimeView(departure.time)
            if departure.isCarFerry {
                Text(Service.car.description(.compact))
            }
            ForEach(departure.deviations) { deviation in
                Text(deviation.description(.compact))
            }
        }
    }
}

struct DepartureView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        DepartureView(Departure(Time(), deviations: [
            .except(.friday)
        ], services: [
            .car
        ]))
    }
}

extension Deviation: Identifiable {
    
    // MARK: Identifiable
    public var id: String {
        return description(.compact)
    }
}
