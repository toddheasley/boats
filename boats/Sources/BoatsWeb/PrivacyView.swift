import Boats

struct PrivacyView: HTMLView {
    let title: String = "Privacy"
    let index: Index
    
    init(_ index: Index = Index()) {
        self.index = index
    }
    
    // MARK: HTMLView
    var html: [HTML] {
        var html: [HTML] = HTML.head(index, title: title)
        html.append("<h1>\(title)</h1>")
        html.append("<p></p>")
        return html
    }
    
    let uri: String = "privacy"
}
