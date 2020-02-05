import Foundation
import BoatsKit

protocol HTMLView: Resource {
    var uri: String {
        get
    }
}

extension HTMLView {
    
    // MARK: Resource
    var path: String {
        return "\(uri).html"
    }
}
