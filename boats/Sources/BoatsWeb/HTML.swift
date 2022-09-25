import Foundation
import Boats

typealias HTML = String

extension HTML {
    static func head(_ index: Boats.Index, title: String? = nil) -> Self {
        var html: [Self] = []
        html.append("<!DOCTYPE html>")
        html.append("<title>\(Site.title(title))</title>")
        html.append(meta("viewport", content: "initial-scale=1.0"))
        html.append(meta("apple-mobile-web-app-title", content: Site.name))
        if let appIdentifier: String = Site.appIdentifier, !appIdentifier.isEmpty {
            html.append(meta("apple-itunes-app", content: "app-id=\(appIdentifier)"))
        }
        html.append(meta("og:image", content: URL(string: ShareImage().path, relativeTo: Site.url)!.absoluteString))
        html.append(meta("og:title", content: Site.title(title)))
        html.append(meta("og:description", content: index.description))
        html.append(link("apple-touch-icon", href: BookmarkIcon().path))
        html.append(link("shortcut icon", href: Favicon().path))
        html.append(link("stylesheet", href: Stylesheet().path))
        return html.joined(separator: "\n")
    }
    
    private static func meta(_ name: String, content: String) -> Self {
        return "<meta name=\"\(name)\" content=\"\(content)\">"
    }
    
    private static func link(_ rel: String, href: String) -> Self {
        return "<link rel=\"\(rel)\" href=\"\(href)\">"
    }
}
