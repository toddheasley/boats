//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public struct Index: Codable {
    public let uri: URI = "index"
    public var name: String = ""
    public var description: String = ""
    public var localization: Localization = Localization()
    public var providers: [Provider] = []
    
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
