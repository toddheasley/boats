import SwiftUI
import Boats

struct IndexTV: View {
    @Environment(Index.self) private var index: Index
    
    // MARK: View
    var body: some View {
        VStack {
            Text("\(index.name) \(index.description)")
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
                                HStack(alignment: .top, spacing: 32.0) {
                                    ForEach(route.schedule()?.timetables ?? []) { timetable in
                                        TimetableView(timetable, origin: index.location, destination: route.location)
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                }
                .padding()
            }
        }
        .backgroundColor()
    }
}

#Preview("TV Index View") {
    IndexTV()
        .environment(Index())
}
