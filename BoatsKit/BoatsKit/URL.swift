//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

protocol URLReadable {
    
}

protocol URLWritable {
    
}

protocol URLDeletable {
    
}

extension URL {
    public init(base url: URL, uri: URI, type: String = "") {
        var url: URL = url
        if !url.hasDirectoryPath {
            url.deleteLastPathComponent()
        }
        self = url.appendingPathComponent("\(uri)\(!type.isEmpty ? ".\(type)" : "")")
    }
}

/*
 extension Index: URLReading, URLWriting {
 public static func read(from url: URL, completion: @escaping (Index?, Error?) -> Void) {
 let url: URL = URL(base: url, uri: Index().uri, type: "json")
 switch url.scheme ?? "" {
 case "https":
 URLSession.shared.dataTask(with: url) { data, response, error in
 DispatchQueue.main.async {
 guard let data: Data = data else {
 completion(nil, error ?? NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: nil))
 return
 }
 do {
 completion(try Index(data: data), nil)
 } catch let error {
 completion(nil, error)
 }
 }
 }
 case "file":
 do {
 completion(try read(from: url), nil)
 } catch let error {
 completion(nil, error)
 }
 default:
 completion(nil, NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil))
 }
 }
 
 public static func read(from url: URL) throws -> Index {
 return try Index(data: try Data(contentsOf: URL(base: url, uri: Index().uri, type: "json")))
 }
 
 public func write(to url: URL) throws {
 try data().write(to: URL(base: url, uri: Index().uri, type: "json"), options: Data.WritingOptions.atomic)
 }
 }*/


