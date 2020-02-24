import Foundation
import BoatsKit

struct Cache {
    let date: Date
    
    var index: Index? {
        return try? Index(data: data)
    }
    
    init?(index: Index) {
        guard let data: Data = try? index.data() else {
            return nil
        }
        self.date = Date()
        self.data = data
    }
    
    private let data: Data
}

extension Cache: Codable {
    
}
