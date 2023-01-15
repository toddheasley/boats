import SwiftUI
import Boats

struct TimetableView: View {
    let timetable: Timetable
    let destination: Location
    let origin: Location
    
    init(_ timetable: Timetable, destination: Location, origin: Location) {
        self.timetable = timetable
        self.destination = destination
        self.origin = origin
    }
    
    // MARK: View
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TimetableView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        Spacer()
        //TimetableView()
    }
}
