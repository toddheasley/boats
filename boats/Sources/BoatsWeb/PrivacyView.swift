import Foundation
import Boats

struct PrivacyView: HTMLView {
    let index: Index
    
    init(_ index: Index = Index()) {
        self.index = index
    }
    
    // MARK: HTMLView
    var html: [HTML] {
        return [
            HTML.head(index, title: "Privacy"),
            .main(index)
        ]
    }
    
    let uri: String = "privacy"
}

extension HTML {
    fileprivate static func main(_ index: Boats.Index) -> Self {
        var html: [Self] = []
        html.append("<main>")
        html.append("    <h1>Privacy</h1>")
        html.append("</main>")
        return html.joined(separator: "\n")
    }
}
