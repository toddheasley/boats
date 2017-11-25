//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit

class ServiceInput: Input {
    private var buttons: [NSButton] = []
    
    var services: [Service] {
        set {
            for (index, service) in Service.all.enumerated() {
                buttons[index].state = newValue.contains(service) ? .on : .off
            }
        }
        get {
            var services: [Service] = []
            for (index, service) in Service.all.enumerated() {
                guard buttons[index].state == .on else {
                    continue
                }
                services.append(service)
            }
            return services
        }
    }
    
    override var allowsSelection: Bool {
        return true
    }
    
    override var u: Int {
        return (Service.all.count / 2) + (Service.all.count % 2 == 1 ? 1 : 0)
    }
    
    override func layout() {
        super.layout()
    }
    
    override func setUp() {
        super.setUp()
        
        for (index, service) in Service.all.enumerated() {
            let button: NSButton = NSButton(checkboxWithTitle: service.rawValue.capitalized, target: self, action: #selector(inputEdited(_:)))
            button.frame.size.width = 120.0
            button.frame.size.height = 22.0
            button.frame.origin.x = intrinsicContentSize.width - (contentInsets.right + (button.frame.size.width * (index % 2 == 1 ? 1.0 : 2.0)))
            button.frame.origin.y = intrinsicContentSize.height - (contentInsets.top + (button.frame.size.height * CGFloat(index / 2 + 1)))
            addSubview(button)
            buttons.append(button)
        }
        
        label = "Services"
    }
}
