import SwiftUI
import Boats

struct IndexView: View {
    @Environment(Index.self) private var index: Index
    @State private var isScrolled: Bool = false
    
    // MARK: View
    var body: some View {
        VStack(spacing: 0.0) {
            Header(isScrolled: isScrolled) {
                TitleLink(index.name, destination: index.url)
                    .frame(maxWidth: .maxWidth)
                    .padding(.horizontal)
                    .padding(.vertical, 5.5)
                TitleView(index.route?.description)
                    .frame(maxWidth: .maxWidth)
                    .padding(.horizontal)
                    .padding(.bottom, 5.0)
                    .padding(.top)
            }
            ScrollView(onScroll: { offset in
                isScrolled = offset.y < -5.0
            }) {
                LazyVStack(spacing: .spacing, pinnedViews: [.sectionHeaders]) {
                    SeasonView(index.route?.schedule()?.season)
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
        .frame(minWidth: 320.0)
        .backgroundColor()
    }
}

#Preview("Index View") {
    IndexView()
        .environment(Index())
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

#Preview("Cell") {
    VStack {
        Header(isScrolled: true) {
            TitleView("Peaks Island")
        }
        Header {
            TitleView("Peaks Island")
        }
    }
}
