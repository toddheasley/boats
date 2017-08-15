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
