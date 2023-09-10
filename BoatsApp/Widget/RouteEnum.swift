import AppIntents
import Boats

enum RouteEnum: String, CaseIterable, AppEnum, CustomStringConvertible {
    case peaks, littleDiamond, greatDiamond, diamondCove, long, chebeague, cliff
    
    var route: Route {
        return Route.allCases[Self.allCases.firstIndex(of: self)!]
    }
    
    init(_ route: Route) {
        self = Self.allCases[Route.allCases.firstIndex(of: route)!]
    }
    
    // MARK: AppEnum
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Route"
    static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .peaks: "Peaks Island",
        .littleDiamond: "Little Diamond Island",
        .greatDiamond: "Great Diamond Island",
        .diamondCove: "Diamond Cove",
        .long: "Long Island",
        .chebeague: "Chebeague Island",
        .cliff: "Cliff Island"
    ]
    
    // MARK: CustomStringConvertible
    var description: String {
        return route.description
    }
}
