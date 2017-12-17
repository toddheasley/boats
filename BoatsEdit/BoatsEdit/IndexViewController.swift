import Cocoa
import BoatsKit
import BoatsWeb

class IndexViewController: NSViewController, PanelViewDelegate {
    private let indexPanelView: IndexPanelView = IndexPanelView()
    private let providerPanelView: ProviderPanelView = ProviderPanelView()
    private let routePanelView: RoutePanelView = RoutePanelView()
    private let locationPanelView: LocationPanelView = LocationPanelView()
    private let schedulePanelView: SchedulePanelView = SchedulePanelView()
    private let holidayPanelView: HolidayPanelView = HolidayPanelView()
    private let departurePanelView: DeparturePanelView = DeparturePanelView()
    
    private var webButton: NSButton {
        return indexPanelView.webButton
    }
    
    private var previewButton: NSToolbarItem? {
        return view.window?.toolbar?.items.last
    }
    
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
    
    @IBAction func toggle(_ sender: AnyObject?) {
        IndexManager.web = webButton.state == .on
        previewButton?.isEnabled = IndexManager.web
    }
    
    // MARK: NSViewController
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
        
        indexPanelView.index = IndexManager.index
        indexPanelView.web = IndexManager.web
        
        webButton.target = self
        webButton.action = #selector(toggle(_:))
        
        previewButton?.target = self
        previewButton?.action = #selector(preview(_:))
        previewButton?.isEnabled = IndexManager.web
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView?.documentView?.autoresizingMask = [.height]
        scrollView?.documentView?.frame.size.height = view.bounds.size.height
        
        indexPanelView.delegate = self
        indexPanelView.autoresizingMask = [.height]
        indexPanelView.frame.size.height = view.bounds.size.height
        scrollView?.documentView?.addSubview(indexPanelView)
        
        providerPanelView.delegate = indexPanelView
        providerPanelView.autoresizingMask = [.height]
        providerPanelView.frame.size.height = view.bounds.size.height
        providerPanelView.frame.origin.x = indexPanelView.intrinsicContentSize.width
        scrollView?.documentView?.addSubview(providerPanelView)
        
        routePanelView.delegate = providerPanelView
        routePanelView.autoresizingMask = [.height]
        routePanelView.frame.size.height = view.bounds.size.height
        routePanelView.frame.origin.x = indexPanelView.intrinsicContentSize.width * 2.0
        scrollView?.documentView?.addSubview(routePanelView)
        
        locationPanelView.delegate = routePanelView
        locationPanelView.autoresizingMask = [.height]
        locationPanelView.frame.size.height = view.bounds.size.height
        locationPanelView.frame.origin.x = indexPanelView.intrinsicContentSize.width * 3.0
        scrollView?.documentView?.addSubview(locationPanelView)
        
        schedulePanelView.delegate = routePanelView
        schedulePanelView.autoresizingMask = [.height]
        schedulePanelView.frame.size.height = view.bounds.size.height
        schedulePanelView.frame.origin.x = locationPanelView.frame.origin.x
        scrollView?.documentView?.addSubview(schedulePanelView)
        
        holidayPanelView.delegate = schedulePanelView
        holidayPanelView.autoresizingMask = [.height]
        holidayPanelView.frame.size.height = view.bounds.size.height
        holidayPanelView.frame.origin.x = indexPanelView.intrinsicContentSize.width * 4.0
        scrollView?.documentView?.addSubview(holidayPanelView)
        
        departurePanelView.delegate = schedulePanelView
        departurePanelView.autoresizingMask = [.height]
        departurePanelView.frame.size.height = view.bounds.size.height
        departurePanelView.frame.origin.x = holidayPanelView.frame.origin.x
        scrollView?.documentView?.addSubview(departurePanelView)
        
        panel(indexPanelView, didSelect: nil)
    }
    
    // MARK: PanelViewDelegate
    func panel(_ view: PanelView, didSelect input: Any?) {
        switch view {
        case is IndexPanelView:
            providerPanelView.localization = indexPanelView.index?.localization
            providerPanelView.provider = input as? Provider
            fallthrough
        case is ProviderPanelView:
            routePanelView.localization = indexPanelView.index?.localization
            routePanelView.route = input as? Route
            fallthrough
        case is RoutePanelView:
            locationPanelView.localization = indexPanelView.index?.localization
            locationPanelView.location = input as? Location
            schedulePanelView.localization = locationPanelView.localization
            schedulePanelView.schedule = input as? Schedule
            fallthrough
        case is SchedulePanelView:
            holidayPanelView.localization = indexPanelView.index?.localization
            holidayPanelView.holiday = input as? Holiday
            departurePanelView.localization = indexPanelView.index?.localization
            departurePanelView.departure = input as? Departure
        default:
            break
        }
        
        var rect: CGRect = indexPanelView.frame
        for panel in [
            providerPanelView,
            routePanelView,
            locationPanelView,
            schedulePanelView,
            holidayPanelView,
            departurePanelView
        ] {
            rect = !panel.isHidden && panel.frame.origin.x > rect.origin.x ? panel.frame : rect
        }
        scrollView?.documentView?.frame.size.width = max(scrollView?.documentView?.frame.size.width ?? 0.0, rect.origin.x + rect.size.width)
        scrollView?.scroll(to: rect) {
            self.scrollView?.documentView?.frame.size.width = rect.origin.x + rect.size.width
        }
    }
    
    func panelDidEdit(_ view: PanelView) {
        try? IndexManager.save(index: indexPanelView.index)
    }
    
    func panelDidDelete(_ view: PanelView) {
        
    }
}

fileprivate extension NSScrollView {
    func scroll(to rect: NSRect, completion: (() -> Void)? = nil) {
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
