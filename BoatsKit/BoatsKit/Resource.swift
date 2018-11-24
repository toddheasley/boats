import Foundation

public protocol Resource {
    var path: String {
        get
    }
    
    func data() throws -> Data
}
