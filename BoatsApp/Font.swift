#if canImport(WidgetKit)
import WidgetKit
#endif
import SwiftUI

extension Font {
#if canImport(WidgetKit)
    static func head(_ widgetFamily: WidgetFamily?) -> Self {
        switch widgetFamily {
        case nil:
            return head
        case .systemExtraLarge:
            return system(size: 28.0, weight: .semibold)
        default:
            return system(size: 15.0, weight: .semibold)
        }
    }
    
#endif
    static var head: Self {
#if os(watchOS) || os(tvOS)
        return system(.body, weight: .semibold)
#else
        return system(.title, weight: .semibold)
#endif
    }
    
    static var season: Self {
#if os(watchOS) || os(tvOS)
        return system(size: 14.0, weight: .medium)
#else
        return system(.body)
#endif
    }

    static var table: Self {
#if os(watchOS)
        return system(size: 12.0, weight: .semibold)
#elseif os(tvOS)
        return system(size: 17.0, weight: .semibold)
#else
        return system(.body, weight: .semibold)
#endif
    }
    
#if canImport(WidgetKit)
    static func time(_ widgetFamily: WidgetFamily?) -> Self {
        switch widgetFamily {
        case nil:
            return time
        case .systemExtraLarge:
            return system(size: 60.0, weight: .bold)
        case .systemSmall:
            return system(size: 20.0, weight: .bold)
        default:
            return system(size: 27.0, weight: .bold)
        }
    }
    
#endif
    static var time: Self {
#if os(watchOS)
        return system(size: 14.0, weight: .semibold)
#elseif os(tvOS)
        return system(.body, weight: .bold)
#else
        return system(.largeTitle, weight: .bold)
#endif
    }
    
#if canImport(WidgetKit)
    static func tiny(_ widgetFamily: WidgetFamily?) -> Self {
        switch widgetFamily {
        case nil:
            return tiny
        case .systemExtraLarge:
            return system(size: 14.0)
        default:
            return system(size: 8.0)
        }
    }
    
#endif
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
        Text("Head")
            .font(.head)
        Text("Season")
            .font(.season)
        Text("Table")
            .font(.table)
        Text("Time")
            .font(.time)
        Text("Tiny")
            .font(.tiny)
    }
}
