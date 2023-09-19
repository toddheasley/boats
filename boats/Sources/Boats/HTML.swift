struct HTML {
    static func convert<T>(_ type: T.Type, from html: String) throws -> T where T: HTMLConvertible {
        return try type.init(from: html)
    }
    
    static func error<T>(_ type: T.Type, from html: String) -> Error {
        return DecodingError.valueNotFound(type, DecodingError.Context(codingPath: [], debugDescription: html))
    }
}
