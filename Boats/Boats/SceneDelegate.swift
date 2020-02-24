import UIKit
import BoatsKit
import BoatsBot

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    // MARK: UIWindowSceneDelegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        #if targetEnvironment(macCatalyst)
        (scene as? UIWindowScene)?.titlebar?.titleVisibility = .hidden
        #endif
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        (window?.rootViewController as? MainViewController)?.refresh()
    }
}
