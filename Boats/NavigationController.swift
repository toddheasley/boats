//
//  NavigationController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class NavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let viewController = viewController as? UINavigationControllerDelegate {
            delegate = viewController
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
    }
    
    convenience init() {
        self.init(rootViewController: MainViewController())
    }
}
