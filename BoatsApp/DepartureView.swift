import SwiftUI
import Boats

struct DepartureView: View {
    let departure: Departure?
    
    init(_ departure: Departure? = nil) {
        self.departure = departure
    }
    
    // MARK: View
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if let departure {
                TimeView(departure.time)
                if departure.isCarFerry {
                    Text(Service.car.description(.compact))
                }
                ForEach(departure.deviations) { deviation in
                    Text(deviation.description(.compact))
                }
            } else {
                Text(" ")
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
        .background {
            Color.preview
        }
    }
}
