//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct Index: URIResource, Codable {
    public var name: String = ""
    public var description: String = ""
    public var localization: Localization = Localization()
    public var providers: [Provider] = []
    
    public var uri: URI {
        return URI(stringLiteral: "index")
    }
    
    public func provider(uri: URI) -> Provider? {
        for provider in providers {
            if provider.uri == uri {
                return provider
            }
        }
        return nil
    }
    
    public init() {
        
    }
}

extension Index: DataCoding {
    
}
