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
    var data: Data {
        return Data.shared
    }
    
    func refreshData() {
        Data.refresh { [weak self] completed in
            self?.dataDidRefresh()
        }
    }
    
    @objc func dataDidRefresh() {
        
    }
    
    override func willActivate() {
        super.willActivate()
        NotificationCenter.default.addObserver(self, selector: #selector(dataDidRefresh), name: TimeChangeNotification, object: nil)
        
        dataDidRefresh()
        if data.providers.count < 1 {
            refreshData()
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        NotificationCenter.default.removeObserver(self, name: TimeChangeNotification, object: nil)
    }
}
