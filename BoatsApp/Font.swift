import SwiftUI

extension Font {
    static var head: Self {
#if os(watchOS)
        return system(.body, weight: .bold)
#elseif os(tvOS)
        return system(.body, weight: .semibold)
#else
        return system(.title, weight: .semibold)
#endif
    }
    
    static var season: Self {
#if os(watchOS) || os(tvOS)
        return system(size: 15.0, weight: .medium)
#else
        return system(.body)
#endif
    }

    static var table: Self {
#if os(watchOS) || os(tvOS)
        return system(size: 17.0, weight: .semibold)
#else
        return system(.body, weight: .semibold)
#endif
    }
    
    static var time: Self {
#if os(watchOS)
        return system(size: 14.0, weight: .semibold)
#elseif os(tvOS)
        return system(.body, weight: .bold)
#else
        return system(.largeTitle, weight: .bold)
#endif
    }
    
    static var tiny: Self {
#if os(watchOS)
        return system(size: 8.0)
#else
        return system(size: 9.5)
#endif
    }
}

#Preview("Font") {
    VStack {
        Text("Head Font")
            .font(.head)
        Text("Season Font")
            .font(.season)
        Text("Table Font")
            .font(.table)
        Text("Time Font")
            .font(.time)
        Text("Tiny Font")
            .font(.tiny)
    }
}
