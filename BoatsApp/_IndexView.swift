import SwiftUI
import Boats

struct IndexView: View {
    @EnvironmentObject private var index: ObservableIndex
    @State private var offset: CGPoint = .zero
    
    // MARK: View
    var body: some View {
        ScrollView(onScroll: { offset in
            self.offset = offset
        }) {
            LazyVStack(spacing: 0.0 - .cellSpacing, pinnedViews: [.sectionHeaders]) {
                TitleView(index.route?.location.name)
                    .padding(.horizontal)
                    .hidden()
                if let route = index.route, let schedule = route.schedule() {
                    SeasonView(schedule.season)
                        .padding()
                    ForEach(schedule.timetables) { timetable in
                        TimetableView(timetable, origin: index.location, destination: route.location, offset: offset)
                            .padding(.horizontal)
                    }
                } else {
                    Text("Schedule Unavailable")
                }
            }
        }
        .refreshable {
            await index.fetch()
        }
        .safeAreaInset(.top) {
            HeaderView(offset)
                .background()
        }
        .safeAreaInset(.bottom, height: 8.0)
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
            .environmentObject(ObservableIndex())
    }
}
