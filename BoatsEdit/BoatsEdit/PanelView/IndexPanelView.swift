import Cocoa
import BoatsKit

class IndexPanelView: PanelView {
    
    
    var index: Index? {
        set {
            var inputViews: [InputView] = []
            
            inputViews.append(StringInputView())
            (inputViews.last as? StringInputView)?.string = newValue?.name
            inputViews.last?.label = "Name"
            inputViews.append(StringInputView())
            (inputViews.last as? StringInputView)?.string = newValue?.description
            inputViews.last?.label = "Description"
            
            inputViews.append(InputView(style: .separator))
            
            inputViews.append(LocalizationInputView())
            (inputViews.last as? LocalizationInputView)?.localization = newValue?.localization
            
            inputViews.append(InputView(style: .separator))
            
            inputViews.append(InputView(style: .custom)) // Providers
            inputViews.last?.label = "Providers"
            for provider in newValue?.providers ?? [] {
                inputViews.append(InputView(style: .label))
                inputViews.last?.label = provider.name
                inputViews.last?.input = provider
            }
            inputViews.append(InputView(style: .label))
            inputViews.last?.placeholder = "New Provider"
            inputViews.last?.input = Provider()
            
            self.inputViews = inputViews
        }
        get {
            var index: Index = Index()
            index.name = (inputViews[0] as? StringInputView)?.string ?? ""
            index.description = (inputViews[1] as? StringInputView)?.string ?? ""
            index.localization = (inputViews[2] as? LocalizationInputView)?.localization ?? Localization()
            for inputView in inputViews {
                if let provider: Provider = inputView.input as? Provider, !provider.name.isEmpty {
                    index.providers.append(provider)
                }
            }
            return index
        }
    }
    
    var web: Bool {
        set {
            panelInputView.web = newValue
        }
        get {
            return panelInputView.web
        }
    }
    
    // MARK: PanelView
    override var localization: Localization? {
        set {
            index?.localization = newValue ?? Localization()
        }
        get {
            return index?.localization
        }
    }
    
    override func dragRange(for i: Int) -> ClosedRange<Int>? {
        var dragEligible: [Int] = []
        for (ii, inputView) in inputViews.enumerated() {
            if let _: String = label,
                let provider: Provider = inputView.input as? Provider, !provider.name.isEmpty {
                dragEligible.append(ii)
            }
        }
        guard dragEligible.count > 1, dragEligible.contains(i) else {
            return nil
        }
        return dragEligible.first!...(dragEligible.last! + 1)
    }
    
    override func setUp() {
        super.setUp()
        
        label = "Index"
        panelInputView.accessory = .web
        
        index = nil
    }
}

/*
    // MARK: PanelViewDelegate
    override func panelDidEdit(_ view: PanelView) {
        if selectedRow == tableView.selectedRow,
            let provider: Provider = (view as? ProviderPanelView)?.provider, !provider.uri.description.isEmpty, !provider.name.isEmpty,
            tableView.selectedRow > 6, tableView.selectedRow < tableView.numberOfRows - 1 {
            providers.input[tableView.selectedRow - 7].provider = provider
            if tableView.selectedRow == tableView.numberOfRows - 2 {
                providers.input.append(ProviderInput())
                tableView.insertRows(at: IndexSet(integer: tableView.selectedRow + 1))
            }
        }
        delegate?.panelDidEdit(self)
    }
    
    override func panelDidDelete(_ view: PanelView) {
        if tableView.selectedRow > 6, tableView.selectedRow < tableView.numberOfRows - 2 {
            providers.input.remove(at: tableView.selectedRow - 7)
        }
        tableView.reloadData()
        delegate?.panel(self, didSelect: nil)
        delegate?.panelDidEdit(self)
    }
*/
