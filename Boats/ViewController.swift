//
//  ViewController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class ViewController: UIViewController {
    var data: Data = Data()
    
    var mode: Mode {
        return (UIApplication.shared.delegate as? AppDelegate)?.mode ?? Mode()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return (mode == .night) ? .lightContent : .default
    }
    
    func refreshData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        data.reloadData { [weak self] completed in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self?.dataDidRefresh()
        }
    }
    
    func dataDidRefresh() {
        
    }
    
    func modeDidChange() {
        setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = .background(mode: mode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataDidRefresh()
        modeDidChange()
        
        NotificationCenter.default.addObserver(self, selector: #selector(modeDidChange), name: ModeChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataDidRefresh), name: TimeChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: ModeChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: TimeChangeNotification, object: nil)
    }
}
