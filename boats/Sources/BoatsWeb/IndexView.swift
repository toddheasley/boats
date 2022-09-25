import Foundation
import Boats

struct IndexView: HTMLView {
    let index: Index
    
    init(_ index: Index = Index()) {
        self.index = index
    }
    
    // MARK: HTMLView
    var html: [HTML] {
        return [
            HTML.head(index),
            .main(index)
        ]
    }
    
    var uri: String {
        return index.uri
    }
}

extension HTML {
    fileprivate static func main(_ index: Boats.Index) -> Self {
        var html: [Self] = []
        html.append("<main>")
        html.append("    <h1>\(index)</h1>")
        html.append("</main>")
        return html.joined(separator: "\n")
    }
}
