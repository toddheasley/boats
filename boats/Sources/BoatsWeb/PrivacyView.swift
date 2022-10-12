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
        html.append("<h2>No Data Collected</h2>")
        html.append("<p>Boats is available for Apple platforms and follows <a href=\"https://www.apple.com/privacy\">Apple privacy</a> guidelines and labeling.</p>")
        html.append("<p>Schedule data is scraped from <a href=\"https://www.cascobaylines.com\">cascobaylines.com</a> and hosted with <a href=\"https://pages.github.com\">GitHub&nbsp;Pages.</a> The entire Boats source code is <a href=\"https://github.com/toddheasley/boats\">publicly available on GitHub</a> under the <a href=\"https://choosealicense.com/licenses/mit\">MIT&nbsp;License.</a></p>")
        return html
    }
    
    let uri: String = "privacy"
}
