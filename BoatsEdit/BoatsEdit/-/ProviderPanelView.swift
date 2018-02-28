import Cocoa
import BoatsKit

class ProviderPanelView: PanelView {
    private let dividerInput: [DividerInput] = [DividerInput(), DividerInput()]
    private let nameInput: StringInput = StringInput()
    private let uriInput: URIInput = URIInput()
    private let urlInput: URLInput = URLInput()
    private var routes: (header: Input, input: [RouteInput]) = (Input(), [RouteInput()])
    
    var provider: Provider? {
        set {
            nameInput.string = newValue?.name
            uriInput.uri = newValue?.uri
            urlInput.url = newValue?.url
            routes.input = []
            for route in newValue?.routes ?? [] {
                routes.input.append(RouteInput(route: route))
            }
            routes.input.append(RouteInput())
            tableView.reloadData()
            isHidden = newValue == nil
        }
        get {
            var provider: Provider = Provider()
            provider.name = nameInput.string ?? ""
            provider.uri = uriInput.uri ?? ""
            provider.url = urlInput.url
            for input in routes.input {
                if let route: Route = input.route {
                    provider.routes.append(route)
                }
            }
            return provider
        }
    }
    
    // MARK: PanelView
    override var localization: Localization? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override var deleteLabel: String? {
        guard let name: String = provider?.name, !name.isEmpty else {
            return "provider"
        }
        return "\(name) provider"
    }
    
    override func dragRange(for row: Int) -> ClosedRange<Int>? {
        guard routes.input.count > 2, (6...(routes.input.count + 4)).contains(row) else {
            return nil
        }
        return 6...(routes.input.count + 5)
    }
    
    override func moveInput(from dragRow: Int, to dropRow: Int) {
        routes.input.move(from: dragRow - 6, to: dropRow - 6)
    }
    
    override func setUp() {
        super.setUp()
        
        headerInput.label = "Provider"
        headerInput.deleteButton.isHidden = false
        nameInput.label = "Name"
        nameInput.delegate = self
        uriInput.delegate = self
        urlInput.delegate = self
        routes.header.label = "Routes"
        
        provider = nil
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 7 + routes.input.count
    }
    
    // MARK: NSTableViewDelegate
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        switch row {
        case 0:
            return headerInput.intrinsicContentSize.height
        case 1:
            return nameInput.intrinsicContentSize.height
        case 2:
            return uriInput.intrinsicContentSize.height
        case 3:
            return urlInput.intrinsicContentSize.height
        case 4:
            return dividerInput[0].intrinsicContentSize.height
        case 5:
            return routes.header.intrinsicContentSize.height
        case tableView.numberOfRows - 1:
            return dividerInput[1].intrinsicContentSize.height
        default:
            return routes.input.first!.intrinsicContentSize.height
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch row {
        case 0:
            return headerInput
        case 1:
            return nameInput
        case 2:
            return uriInput
        case 3:
            return urlInput
        case 4:
            return dividerInput[0]
        case 5:
            return routes.header
        case tableView.numberOfRows - 1:
            return dividerInput[1]
        default:
            return routes.input[row - 6]
        }
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow > 5 {
            delegate?.panel(self, didSelect: provider?.route(at: tableView.selectedRow - 6) ?? Route())
            selectedRow = tableView.selectedRow
        } else {
            delegate?.panel(self, didSelect: nil)
            selectedRow = -1
        }
    }
    
    // MARK: PanelViewDelegate
    override func panelDidEdit(_ view: PanelView) {
        if selectedRow == tableView.selectedRow,
            let route: Route = (view as? RoutePanelView)?.route, !route.uri.description.isEmpty, !route.name.isEmpty,
            tableView.selectedRow > 5, tableView.selectedRow < tableView.numberOfRows - 1 {
            routes.input[tableView.selectedRow - 6].route = route
            if tableView.selectedRow == tableView.numberOfRows - 2 {
                routes.input.append(RouteInput())
                tableView.insertRows(at: IndexSet(integer: tableView.selectedRow + 1))
            }
        }
        delegate?.panelDidEdit(self)
    }
    
    override func panelDidDelete(_ view: PanelView) {
        if tableView.selectedRow > 5, tableView.selectedRow < tableView.numberOfRows - 2 {
            routes.input.remove(at: tableView.selectedRow - 6)
        }
        tableView.reloadData()
        delegate?.panel(self, didSelect: nil)
        delegate?.panelDidEdit(self)
    }
}
