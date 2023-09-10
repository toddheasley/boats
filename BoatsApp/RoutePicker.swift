import SwiftUI
import Boats

struct RoutePicker: View {
    @Environment(Index.self) private var index: Index
    @State private var isPresented: Bool = false
    
    private let title: String = "Routes"
    private let systemImage: String = "ferry.fill"
    
    // MARK: View
    var body: some View {
#if os(macOS)
        Button(action: {
            isPresented = true
        }) {
            Label(title, systemImage: systemImage)
                .foregroundColor(.secondary)
                .padding(.vertical, -1.5)
        }
        .buttonStyle(.bordered)
        .popover(isPresented: $isPresented) {
            VStack {
                ForEach(index.routes) { route in
                    Button(action: {
                        index.route = route
                        isPresented = false
                    }) {
                        HStack {
                            Text(route.location.name)
                            Spacer()
                        }
                    }
                    .buttonStyle(.borderless)
                }
            }
            .padding()
        }
#elseif os(iOS)
        Menu {
            ForEach(index.routes) { route in
                Button(action: {
                    index.route = route
                }) {
                    Text(route.location.name)
                }
            }
        } label: {
            Label(title, systemImage: systemImage)
        }
        .buttonStyle(.borderedProminent)
#elseif os(watchOS)
        Button(action: {
            isPresented = true
        }) {
            Label(title, systemImage: systemImage)
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $isPresented) {
            ScrollView {
                VStack {
                    ForEach(index.routes) { route in
                        Button(action: {
                            index.route = route
                            isPresented = false
                        }) {
                            HStack {
                                Text(route.location.name)
                                    .lineLimit(1)
                                Spacer()
                            }
                        }
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
        .labelStyle(.iconOnly)
        .padding()
}
