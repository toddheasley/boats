import SwiftUI
import BoatsWeb
import Boats

struct IndexView: View {
    @Environment(Index.self) private var index: Index
    @State private var isScrolled: Bool = false
    
    // MARK: View
    var body: some View {
        VStack(spacing: 0.0) {
            Header(isScrolled: isScrolled) {
#if os(watchOS)
                HStack {
                    RouteLabel(index.route)
                    RoutePicker()
                        .labelStyle(.iconOnly)
                }
                .padding(.top, -10.0)
                .padding(.horizontal)
                .padding(.bottom, 5.0)
#else
                VStack(spacing: 0.0) {
                    Toolbar()
                        .padding(.bottom)
                    RouteLabel(index.route)
                        .frame(maxWidth: .maxWidth)
                }
                .padding(.horizontal)
                .padding(.bottom, 5.0)
                .padding(.top)
#endif
            }
            ScrollView(onScroll: { offset in
                isScrolled = offset.y < -5.0
            }) {
                LazyVStack(spacing: .spacing, pinnedViews: [.sectionHeaders]) {
                    SeasonLabel(index.route?.schedule()?.season)
                        .padding(.top, 5.0)
                    ForEach(index.route?.schedule()?.timetables ?? []) { timetable in
                        TimetableView(timetable, origin: index.location, destination: index.route?.location)
                    }
                }
                .frame(maxWidth: .maxWidth)
                .padding(.horizontal)
            }
            .refreshable {
                await index.fetch()
            }
        }
        .backgroundColor()
    }
}

#Preview("Index View") {
    IndexView()
        .environment(Index())
}

// MARK: Toolbar
private struct Toolbar: View {
    @Environment(Index.self) private var index: Index
    
    // MARK: View
    var body: some View {
#if os(macOS)
        HStack(alignment: .top, spacing: 0.0) {
            RoutePicker()
                .labelStyle(.iconOnly)
                .padding(.leading, -7.0)
                .opacity(0.0)
            Spacer()
            Link(destination: index.url) {
                Text(index.name.description)
                    .lineLimit(1)
            }
            Spacer()
            RoutePicker()
                .labelStyle(.iconOnly)
                .padding(.trailing, -7.0)
                .padding(.top, 1.0)
        }
        .padding(.top, -9.0)
#elseif os(iOS)
        HStack(spacing: 0.0) {
            Link(destination: index.url) {
                Text(index.name.description)
                    .lineLimit(1)
            }
            Spacer()
            RoutePicker()
                .labelStyle(.iconOnly)
                .padding(.trailing, 5.0)
        }
        .frame(maxWidth: .maxWidth)
        .padding(.horizontal, 1.5)
        .padding(.top, -12.0)
#elseif os(watchOS)
        RoutePicker()
            .labelStyle(.iconOnly)
#endif
    }
}

#Preview("Toolbar") {
    Toolbar()
        .environment(Index())
        .backgroundColor(.haze)
}

// MARK: RouteLabel
private struct RouteLabel: View {
    let route: Route?
    
    init(_ route: Route? = nil) {
        self.route = route
    }
    
    private var description: String {
        return route?.description ?? ""
    }
    
    // MARK: View
    var body: some View {
        HStack(spacing: 0.0) {
            Text(description)
                .head()
                .lineLimit(1)
            Spacer()
        }
    }
}

#Preview("Route Label") {
    RouteLabel(.peaks)
        .backgroundColor(.haze)
}

// MARK: SeasonLabel
private struct SeasonLabel: View {
    let season: Season?
    
    init(_ season: Season? = nil) {
        self.season = season
    }
    
    private var description: String {
        return season?.description ?? "Schedule unavailable"
    }
    
    // MARK: View
    var body: some View {
        HStack(spacing: 0.0) {
            Text(description)
#if os(watchOS)
                .font(.footnote)
#endif
                .lineLimit(1)
                .opacity(0.9)
            Spacer()
        }
    }
}

#Preview("Season Label") {
    VStack(spacing: .spacing) {
        SeasonLabel(Season(.spring, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1681531200.0), duration: 5443199.0)))
            .backgroundColor(.haze)
        SeasonLabel()
            .backgroundColor(.haze)
    }
}

// MARK: Header
private struct Header<Content: View>: View {
    let content: () -> Content
    let isScrolled: Bool
    
    init(isScrolled: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.isScrolled = isScrolled
    }
    
    // MARK: View
    var body: some View {
        VStack(spacing: 0.0) {
            content()
            Divider()
                .opacity(isScrolled ? 1.0 : 0.0)
        }
        .backgroundColor(isScrolled ? .haze.opacity(0.3) : .clear)
    }
}

#Preview("Header") {
    VStack {
        Header {
            Text("Chebeague Island")
                .head()
        }
        Header(isScrolled: true) {
            Text("Peaks Island")
                .head()
        }
    }
}
