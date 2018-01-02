import Foundation
import BoatsKit

class RouteHTMLView: HTMLView, HTMLDataSource {
    
    // MARK: HTMLDataSource
    func value(of name: String, at index: Int?, in html: HTML) -> String? {
        return nil
    }
    
    func count(of name: String, in html: HTML) -> Int {
        return 0
    }
}
