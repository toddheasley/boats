//
//  BoatsWeb
//  © 2017 @toddheasley
//

import Foundation
import BoatsKit

struct IndexView {
    private(set) var index: Index
    
    init(index: Index) {
        self.index = index
    }
}

extension IndexView: HTMLView {
    var document: HTMLDocument {
        return HTMLDocument(uri: index.uri, html: [
            HTML.head(title: "\(index.name)\(!index.description.isEmpty ? " - \(index.description)" : "")"),
            HTML.body(html: [
                HTML.header(h1: "\(index.name)", h2: "\(index.description)")
            ])
        ])
    }
}
