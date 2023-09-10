import SwiftUI

extension Font {
    static var head: Self {
#if os(watchOS)
        return system(.headline, weight: .bold)
#else
        return system(.title, weight: .semibold)
#endif
    }
    
    static var time: Self {
#if os(watchOS)
        return system(.headline, weight: .bold)
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
    VStack(spacing: .spacing) {
        Text("Time Font")
            .font(.time)
        Text("Tiny Font")
            .font(.tiny)
    }
}
