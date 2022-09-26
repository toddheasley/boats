import Foundation
import Boats

struct Favicon: Resource {
    
    // MARK: Resource
    public let path: String = "favicon.ico"
    
    public func data() throws -> Data {
        return Favicon_Data
    }
}

private let Favicon_Data: Data = Data(base64Encoded: """
iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABGdBTUEAALGPC/xhBQAAADhlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAAqACAAQAAAABAAAAQKADAAQAAAABAAAAQAAAAABlmWCKAAAAX0lEQVR4Ae3QAQ0AAADCoPdPbQ43iEBhwIABAwYMGDBgwIABAwYMGDBgwIABAwYMGDBgwIABAwYMGDBgwIABAwYMGDBgwIABAwYMGDBgwIABAwYMGDBgwIABAwYMvA8MQEAAARZBmOsAAAAASUVORK5CYII=
""")!
