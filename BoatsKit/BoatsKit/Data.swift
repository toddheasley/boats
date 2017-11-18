//
// © 2017 @toddheasley
//

import Foundation

public typealias DataCoding = DataDecoding & DataEncoding

public protocol DataDecoding {
    init(data: Data) throws
}

extension DataDecoding where Self: Decodable {
    public init(data: Data) throws {
        self = try JSON.decoder.decode(Self.self, from: data)
    }
}

public protocol DataEncoding {
    func data() throws -> Data
}

extension DataEncoding where Self: Encodable {
    public func data() throws -> Data {
        return try JSON.encoder.encode(self)
    }
}

public protocol DataResource {
    var uri: URI {
        get
    }
}

public protocol DataReading {
    static func read(from url: URL, completion: @escaping (Self?, Error?) -> Void)
    init(url: URL) throws
}

public protocol DataWriting {
    func write(to url: URL) throws
}

extension DataWriting where Self: DataResource, Self: DataEncoding {
    public func write(to url: URL) throws {
        try data().write(to: url.appending(uri: uri))
    }
}

public protocol DataDeleting {
    func delete(from url: URL) throws
}

extension DataDeleting where Self: DataResource {
    public func delete(from url: URL) throws {
        try FileManager.default.removeItem(at: url.appending(uri: uri))
    }
}
