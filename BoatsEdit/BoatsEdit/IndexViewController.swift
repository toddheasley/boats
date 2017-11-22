//
// © 2017 @toddheasley
//

import Cocoa
import BoatsKit
import BoatsWeb

class IndexViewController: NSViewController, InputGroupDelegate {
    private let indexInputGroup: IndexInputGroup = IndexInputGroup()
    private let providerInputGroup: ProviderInputGroup = ProviderInputGroup()
    private let routeInputGroup: RouteInputGroup = RouteInputGroup()
    private let locationInputGroup: LocationInputGroup = LocationInputGroup()
    private let scheduleInputGroup: ScheduleInputGroup = ScheduleInputGroup()
    private let departureInputGroup: DepartureInputGroup = DepartureInputGroup()
    
    @IBOutlet var scrollView: NSScrollView?
    
    @IBAction func show(_ sender: AnyObject?) {
        guard let url: URL = IndexManager.url else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func preview(_ sender: AnyObject?) {
        guard IndexManager.web, let url: URL = IndexManager.url else {
            return
        }
        NSWorkspace.shared.openFile(url.appending(uri: Site.uri).path)
    }
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.tag {
        case 3:
            return IndexManager.index != nil
        case 4:
            return IndexManager.web
        default:
            return true
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        indexInputGroup.index = IndexManager.index
        providerInputGroup.localization = indexInputGroup.index?.localization
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView?.documentView?.autoresizingMask = [.height]
        scrollView?.documentView?.frame.size.height = view.bounds.size.height
        
        indexInputGroup.delegate = self
        indexInputGroup.autoresizingMask = [.height]
        indexInputGroup.frame.size.height = view.bounds.size.height
        scrollView?.documentView?.addSubview(indexInputGroup)
        
        providerInputGroup.delegate = self
        providerInputGroup.autoresizingMask = [.height]
        providerInputGroup.frame.size.height = view.bounds.size.height
        providerInputGroup.frame.origin.x = indexInputGroup.intrinsicContentSize.width
        scrollView?.documentView?.addSubview(providerInputGroup)
        
        routeInputGroup.delegate = self
        routeInputGroup.autoresizingMask = [.height]
        routeInputGroup.frame.size.height = view.bounds.size.height
        routeInputGroup.frame.origin.x = indexInputGroup.intrinsicContentSize.width * 2.0
        scrollView?.documentView?.addSubview(routeInputGroup)
        
        locationInputGroup.delegate = self
        locationInputGroup.autoresizingMask = [.height]
        locationInputGroup.frame.size.height = view.bounds.size.height
        locationInputGroup.frame.origin.x = indexInputGroup.intrinsicContentSize.width * 3.0
        scrollView?.documentView?.addSubview(locationInputGroup)
        
        scheduleInputGroup.delegate = self
        scheduleInputGroup.autoresizingMask = [.height]
        scheduleInputGroup.frame.size.height = view.bounds.size.height
        scheduleInputGroup.frame.origin.x = locationInputGroup.frame.origin.x
        scrollView?.documentView?.addSubview(scheduleInputGroup)
        
        departureInputGroup.delegate = self
        departureInputGroup.autoresizingMask = [.height]
        departureInputGroup.frame.size.height = view.bounds.size.height
        departureInputGroup.frame.origin.x = indexInputGroup.intrinsicContentSize.width * 4.0
        scrollView?.documentView?.addSubview(departureInputGroup)
    }
    
    // MARK: InputGroupDelegate
    func input(group: InputGroup, didSelect input: Any?) {
        switch group {
        case is IndexInputGroup:
            providerInputGroup.localization = indexInputGroup.index?.localization
            providerInputGroup.provider = input as? Provider
            fallthrough
        case is ProviderInputGroup:
            routeInputGroup.localization = indexInputGroup.index?.localization
            routeInputGroup.route = input as? Route
            fallthrough
        case is RouteInputGroup:
            locationInputGroup.localization = indexInputGroup.index?.localization
            locationInputGroup.location = input as? Location
            scheduleInputGroup.localization = locationInputGroup.localization
            scheduleInputGroup.schedule = input as? Schedule
            fallthrough
        case is ScheduleInputGroup:
            departureInputGroup.localization = indexInputGroup.index?.localization
            departureInputGroup.departure = input as? Departure
        default:
            break
        }
        
        var rect: CGRect = indexInputGroup.frame
        for group in [
            providerInputGroup,
            routeInputGroup,
            locationInputGroup,
            scheduleInputGroup,
            departureInputGroup
        ] {
            rect = !group.isHidden && group.frame.origin.x > rect.origin.x ? group.frame : rect
        }
        scrollView?.documentView?.frame.size.width = max(scrollView?.documentView?.frame.size.width ?? 0.0, rect.origin.x + rect.size.width)
        scrollView?.scroll(to: rect) {
            self.scrollView?.documentView?.frame.size.width = rect.origin.x + rect.size.width
        }
    }
}

extension NSScrollView {
    fileprivate func scroll(to rect: NSRect, completion: (() -> Void)? = nil) {
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 0.35
        contentView.animator().setBoundsOrigin(NSPoint(x: (rect.origin.x + rect.size.width) - visibleRect.size.width, y: 0.0))
        reflectScrolledClipView(contentView)
        NSAnimationContext.endGrouping()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            completion?()
        }
    }
}
