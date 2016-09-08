//
//  Context.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation
import BoatsData

struct Context {
    var provider: Provider
    var route: Route
    var direction: Direction
    
    init(provider: Provider, route: Route, direction: Direction = .destination) {
        self.provider = provider
        self.route = route
        self.direction = direction
    }
}

extension UserDefaults {
    var context: Context? {
        set {
            if let context = newValue {
                set([context.provider.code,context.route.code, context.direction.rawValue], forKey: "context")
            } else {
                set(nil, forKey: "context")
            }
        }
        get {
            if let context = object(forKey: "context") as? [String], context.count == 3, let provider = Data.shared.provider(code: context[0]), let route = provider.route(code: context[1]), let direction = Direction(rawValue: context[2]) {
                return Context(provider: provider, route: route, direction: direction)

            }
            return nil
        }
    }
}
