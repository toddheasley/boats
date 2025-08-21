import SwiftUI
import Boats

struct RoutePicker: View {
    @Environment(Index.self) private var index: Index
    @State private var isPresented: Bool = false
    
    // MARK: View
    var body: some View {
#if os(macOS)
        Button(action: {
            isPresented = true
        }) {
            RoutePickerLabel()
        }
        .popover(isPresented: $isPresented) {
            VStack(spacing: .spacing) {
                ForEach(index.routes) { route in
                    RouteButton(route) {
                        index.route = route
                        isPresented = false
                    }
                    .buttonStyle(.accessoryBar)
                }
            }
            .padding()
        }
        .buttonStyle(.borderedProminent)
#elseif os(iOS)
        Menu {
            ForEach(index.routes) { route in
                RouteButton(route) {
                    index.route = route
                }
            }
        } label: {
            RoutePickerLabel()
                .labelStyle(.titleAndIcon)
        }
        .buttonStyle(.borderedProminent)
#elseif os(watchOS)
        Button(action: {
            isPresented = true
        }) {
            RoutePickerLabel()
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $isPresented) {
            ScrollView {
                VStack {
                    ForEach(index.routes) { route in
                        RouteButton(route) {
                            index.route = route
                            isPresented = false
                        }
                        .buttonStyle(.borderless)
                        .padding()
                    }
                }
            }
        }
#endif
    }
}

#Preview("Route Picker") {
    RoutePicker()
        .environment(Index())
        .padding()
}

private struct RoutePickerLabel: View {
    
    // MARK: View
    var body: some View {
        Label("Routes", systemImage: "ferry.fill")
    }
}

#Preview("Route Picker Label") {
    RoutePickerLabel()
}

private struct RouteButton: View {
    init(_ route: Route, action: @escaping @MainActor () -> Void) {
        self.action = action
        self.route = route
    }
    
    private let action: () -> Void
    private let route: Route
    
    // MARK: View
    var body: some View {
        Button(action: action) {
            HStack {
                Text(route.location.name)
                    .lineLimit(1)
                Spacer()
            }
        }
    }
}

#Preview("Route Button") {
    RouteButton(.peaks) {
        
    }
}
