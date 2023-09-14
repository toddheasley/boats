import AppIntents
import Boats

enum RouteEnum: Int, CaseIterable, AppEnum, CustomStringConvertible {
    case peaks, littleDiamond, greatDiamond, diamondCove, long, chebeague, cliff
    
    init(_ route: Route) {
        self = Self.allCases[Route.allCases.firstIndex(of: route)!]
    }
    
    // MARK: AppEnum
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Route"
    static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .peaks: "Peaks",
        .littleDiamond: "Little Diamond",
        .greatDiamond: "Great Diamond",
        .diamondCove: "Diamond Cove",
        .long: "Long",
        .chebeague: "Chebeague",
        .cliff: "Cliff"
    ]
    
    // MARK: CustomStringConvertible
    var description: String {
        return [
            "Peaks",
            "Little Diamond",
            "Great Diamond",
            "Diamond Cove",
            "Long",
            "Chebeague",
            "Cliff"
        ][rawValue]
    }
}
