import Boats
import BoatsWeb

struct IndexView: TextView {
    let index: Index
    
    init(_ index: Index) {
        self.index = index
    }
    
    // MARK: TextView
    var text: [Text] {
        var text: [Text] = []
        text.append("")
        text.append(Site(index).description)
        text.append(index.url.absoluteString)
        text.append("")
        for route in index.routes {
            text += RouteView(route).text
        }
        return text
    }
}
