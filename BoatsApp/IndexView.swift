import SwiftUI
import Boats

struct IndexView: View {
    @Environment(Index.self) private var index: Index
    
    // MARK: View
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                TitleView(index.route?.description)
                if let route = index.route, let schedule = route.schedule() {
                    SeasonView(schedule.season)
                    ForEach(schedule.timetables) { timetable in
                        TimetableView(timetable, origin: index.location, destination: route.location)
                    }
                } else {
                    SeasonView()
                }
            }
        }
        .refreshable {
            await index.fetch()
        }
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
            .environment(Index())
    }
}
