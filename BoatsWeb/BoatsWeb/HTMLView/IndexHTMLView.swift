import Foundation
import BoatsKit

class IndexHTMLView: HTMLView {
    required public init(index: Index) {
        super.init()
        self.name = URI(resource: "\(index.uri)")
        self.html = HTML(stringLiteral: "<!-- \(index.name) - \(index.description) -->")
    }
}
