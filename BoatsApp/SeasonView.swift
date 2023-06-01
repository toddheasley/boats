import SwiftUI
import Boats

struct SeasonView: View {
    init(_ season: Season) {
        self.season = season.description.components(separatedBy: ": ")
    }
    
    private let season: [String]
    
    // MARK: View
    var body: some View {
        HStack {
            HStack(spacing: 2.5) {
                Text(season.first ?? "")
                    .padding(8.0)
                    .background(Color.preview)
                Text(season.last ?? "")
                    .padding(8.0)
                    .background(Color.preview)
            }
            .cornerRadius(8.0)
            Spacer()
        }
    }
}

struct SeasonView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SeasonView(.preview)
            .padding()
    }
}

private extension Season {
    static var preview: Self {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return try! decoder.decode(Self.self, from: Season_JSON)
    }
}

private let Season_JSON: Data = """
{
    "name": "spring",
    "dateInterval": {
        "start":1681531200,
        "duration":5443199
    }
}
""".data(using: .utf8)!
