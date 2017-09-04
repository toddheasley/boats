//
//  BoatsKit
//  © 2017 @toddheasley
//

import Foundation

public typealias DataCoding = DataDecoding & DataEncoding

public protocol DataDecoding {
    init(data: Data) throws
}

public protocol DataEncoding {
    func data() throws -> Data
}

extension DataDecoding where Self: Decodable {
    public init(data: Data) throws {
        self = try JSON.decoder.decode(Self.self, from: data)
    }
}

extension DataEncoding where Self: Encodable {
    public func data() throws -> Data {
        return try JSON.encoder.encode(self)
    }
}
