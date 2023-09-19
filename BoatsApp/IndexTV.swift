import SwiftUI
import Boats

struct IndexTV: View {
    @Environment(Index.self) private var index: Index
    
    // MARK: View
    var body: some View {
        VStack {
            Text("\(index.name) \(index.description)")
                .font(.table)
                .opacity(0.9)
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top) {
                    ForEach(index.routes) { route in
                        Button(action: {
                            Task {
                                await index.fetch()
                            }
                        }) {
                            VStack {
                                RouteLabel(route)
                                SeasonLabel(route.schedule()?.season)
                                HStack(alignment: .top, spacing: 40.0) {
                                    ForEach(route.schedule()?.timetables ?? []) { timetable in
                                        TimetableView(timetable, origin: index.location, destination: route.location)
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                }
                .padding(.vertical, 40.0)
            }
        }
        .backgroundColor()
    }
}

#Preview("TV Index View") {
    IndexTV()
        .environment(Index())
}
