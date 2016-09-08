//
//  RouteInterfaceController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import WatchKit
import Foundation
import BoatsData

class RouteInterfaceController: InterfaceController {
    var context: Context! {
        didSet {
            UserDefaults.standard.context = context
        }
    }
    
    @IBOutlet weak var routeLabel: WKInterfaceLabel!
    @IBOutlet weak var directionButton: WKInterfaceButton!
    @IBOutlet weak var providerLabel: WKInterfaceLabel!
    @IBOutlet weak var statusLabel: WKInterfaceLabel!
    @IBOutlet weak var carsImage: WKInterfaceImage!
    @IBOutlet weak var hour1Label: WKInterfaceLabel!
    @IBOutlet weak var hour2Label: WKInterfaceLabel!
    @IBOutlet weak var separatorLabel: WKInterfaceLabel!
    @IBOutlet weak var minute1Label: WKInterfaceLabel!
    @IBOutlet weak var minute2Label: WKInterfaceLabel!
    @IBOutlet weak var periodLabel: WKInterfaceLabel!
    
    @IBAction func changeDirection() {
        context.direction = (context.direction == .origin) ? .destination : .origin
        refreshDeparture()
    }
    
    private func refreshDeparture() {
        let alpha: CGFloat = 0.15
        let components = Time.components()
        separatorLabel.setText("\(components[2])")
        periodLabel.setText("\(components[5])")
        if let departure = context.route.schedule()?.departure(direction: context.direction) {
            hour1Label.setText("\(departure.time.components[0])")
            hour2Label.setText("\(departure.time.components[1])")
            minute1Label.setText("\(departure.time.components[3])")
            minute2Label.setText("\(departure.time.components[4])")
            
            statusLabel.setAlpha(1.0)
            carsImage.setAlpha(departure.cars ? 1.0 : alpha)
            hour1Label.setAlpha(departure.time.components[0] != components[0] ? 1.0 : alpha)
            hour2Label.setAlpha(1.0)
            separatorLabel.setAlpha(1.0)
            minute1Label.setAlpha(1.0)
            minute2Label.setAlpha(1.0)
            periodLabel.setAlpha(departure.time.components[5].isEmpty ? alpha : 1.0)
        } else {
            hour1Label.setText("\(components[0])")
            hour2Label.setText("\(components[1])")
            minute1Label.setText("\(components[3])")
            minute2Label.setText("\(components[4])")
            
            statusLabel.setAlpha(alpha)
            carsImage.setAlpha(alpha)
            hour1Label.setAlpha(alpha)
            hour2Label.setAlpha(alpha)
            separatorLabel.setAlpha(alpha)
            minute1Label.setAlpha(alpha)
            minute2Label.setAlpha(alpha)
            periodLabel.setAlpha(alpha)
        }
        let title: String = (context.direction == .destination) ? "From" : "To"
        directionButton.setTitle("\(title) \(context.route.origin.name)".uppercased())
    }
    
    override func dataDidRefresh() {
        super.dataDidRefresh()
        
        guard let provider = data.provider(code: context.provider.code), let route = provider.route(code: context.route.code) else {
            popToRootController()
            return
        }
        context.provider = provider
        context.route = route
        
        routeLabel.setText("\(context.route.name)")
        providerLabel.setText("\(context.provider.name)")
        refreshDeparture()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard let context = context as? Context else {
            popToRootController()
            return
        }
        self.context = context
        dataDidRefresh()
    }
}
