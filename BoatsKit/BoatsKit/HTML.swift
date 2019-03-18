import Foundation

let HTMLErrorDomain: String = "HTMLErrorDomain"
let HTMLConvertibleError: Int = 1620

protocol HTMLConvertible {
    init(from html: String) throws
}

struct HTML {
    static func convert<T>(_ type: T.Type, from html: String) throws -> T where T: HTMLConvertible {
        return try type.init(from: html)
    }
    
    static func error<T>(_ type: T.Type, from html: String) -> NSError {
        return NSError(domain: HTMLErrorDomain, code: HTMLConvertibleError)
    }
}
