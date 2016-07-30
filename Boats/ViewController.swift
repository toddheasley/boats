//
//  ViewController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class ViewController: UIViewController, UINavigationControllerDelegate {
    var data: Data = Data()
    
    func refreshData() {
        UIApplication.shared().isNetworkActivityIndicatorVisible = true
        data.reloadData() { [weak self] completed in
            UIApplication.shared().isNetworkActivityIndicatorVisible = false
            self?.dataDidRefresh(completed: completed)
        }
    }
    
    func dataDidRefresh(completed: Bool) {
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIColor.statusBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidLayoutSubviews), name: TimeChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: TimeChangeNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .background
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
