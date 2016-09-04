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
    var provider: Provider!
    var route: Route!
    
    var direction: Direction = .destination {
        didSet {
            let title: String = (direction == .destination) ? "From" : "To"
            directionButton.setTitle("\(title) \(route.origin.name)".uppercased())
            refreshDeparture()
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
        direction = (direction == .origin) ? .destination : .origin
    }
    
    private func refreshDeparture() {
        let alpha: CGFloat = 0.15
        if let departure = route.schedule()?.departure(direction: direction) {
            var hour = String(format: "%02d", (!Time.is24Hour && (departure.time.hour < 1 || departure.time.hour > 12)) ? abs(departure.time.hour - 12) : departure.time.hour)
            var minute = String(format: "%02d", departure.time.minute)
            hour1Label.setText("\(hour.characters.first!)")
            hour2Label.setText("\(hour.characters.last!)")
            minute1Label.setText("\(minute.characters.first!)")
            minute2Label.setText("\(minute.characters.last!)")
            
            statusLabel.setAlpha(1.0)
            carsImage.setAlpha(departure.cars ? 1.0 : alpha)
            hour1Label.setAlpha(hour.characters.first! != "0" ? 1.0 : alpha)
            hour2Label.setAlpha(1.0)
            separatorLabel.setAlpha(1.0)
            minute1Label.setAlpha(1.0)
            minute2Label.setAlpha(1.0)
            periodLabel.setAlpha((Time.is24Hour || departure.time.hour < 12) ? alpha : 1.0)
        } else {
            hour1Label.setText("0")
            hour2Label.setText("0")
            minute1Label.setText("0")
            minute2Label.setText("0")
            
            statusLabel.setAlpha(alpha)
            carsImage.setAlpha(alpha)
            hour1Label.setAlpha(alpha)
            hour2Label.setAlpha(alpha)
            separatorLabel.setAlpha(alpha)
            minute1Label.setAlpha(alpha)
            minute2Label.setAlpha(alpha)
            periodLabel.setAlpha(alpha)
        }
    }
    
    override func dataDidRefresh() {
        super.dataDidRefresh()
        
        guard let provider = data.provider(code: self.provider.code), let route = provider.route(code: self.route.code) else {
            popToRootController()
            return
        }
        self.provider = provider
        self.route = route
        
        routeLabel.setText("\(self.route.name)")
        providerLabel.setText("\(self.provider.name)")
        refreshDeparture()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard let route = context as? Route else {
            popToRootController()
            return
        }
        self.route = route
        for provider in data.providers {
            if let _ = provider.route(code: route.code) {
                self.provider = provider
                break
            }
        }
        direction = Direction(rawValue: direction.rawValue)!
        dataDidRefresh()
    }
}
