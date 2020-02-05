import Foundation
import BoatsKit

extension UserDefaults {
    public static let shared: UserDefaults = UserDefaults(suiteName: "group.toddheasley.boats") ?? .standard
}
