//
//  MainInterfaceController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import WatchKit
import Foundation
import BoatsData

class MainInterfaceController: InterfaceController {
    private var rows: [(route: Route, provider: Provider)] = []
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    override func dataDidRefresh() {
        super.dataDidRefresh()
        
        rows = []
        for provider in data.providers {
            rows.append(contentsOf: provider.routes.map { route in
                (route, provider)
            })
        }
        table.setNumberOfRows(rows.count, withRowType: "RouteRow")
        for (index, row) in rows.enumerated() {
            guard let rowController = table.rowController(at: index) as? RouteRowController else {
                continue
            }
            rowController.routeLabel.setText("\(row.route.name)")
            rowController.originLabel.setText("From \(row.route.origin.name)")
            rowController.providerLabel.setText("\(row.provider.name)")
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        super.table(table, didSelectRowAt: rowIndex)
        pushController(withName: "Route", context: rows[rowIndex].route)
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Boats")
    }
}