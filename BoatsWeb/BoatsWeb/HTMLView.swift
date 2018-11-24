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

extension HTMLView where Self: HTMLDataSource {
    
    // MARK: Resource
    func data() throws -> Data {
        var html: HTML = try HTML(data: try Data(contentsOf: try URL.bundle(resource: String(describing: type(of: self)), type: "html")))
        html.dataSource = self
        return try html.data()
    }
}
