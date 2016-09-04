//
//  InterfaceController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import WatchKit
import Foundation
import BoatsData

class InterfaceController: WKInterfaceController {
    var data: Data = Data()
    
    func refreshData() {
        data.reloadData() { [weak self] completed in
            self?.dataDidRefresh()
        }
    }
    
    func dataDidRefresh() {
        
    }
    
    override func willActivate() {
        super.willActivate()
        NotificationCenter.default.addObserver(self, selector: #selector(dataDidRefresh), name: TimeChangeNotification, object: nil)
        refreshData()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        NotificationCenter.default.removeObserver(self, name: TimeChangeNotification, object: nil)
    }
}
