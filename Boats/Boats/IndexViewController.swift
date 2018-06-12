import UIKit
import BoatsKit

class IndexViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    private var date: Date?
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var toolbar: IndexToolbar?
    
    private(set) var index: Index? {
        didSet {
            date = index != nil ? Date() : nil
        }
    }
    
    @objc func reloadIndex() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Index.read(from: URL(string: "https://toddheasley.github.io/boats/index.json")!) { index, error in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.tableView?.refreshControl?.endRefreshing()
            
            guard let index: Index = index else {
                return
            }
            self.index = index
            self.handleTimeChange()
            
            guard let routeViewController: RouteViewController = self.presentedViewController as? RouteViewController,
                let provider: Provider = index.provider(uri: routeViewController.provider?.uri),
                let route: Route = provider.route(uri: routeViewController.route?.uri) else {
                self.dismiss(animated: false)
                return
            }
            routeViewController.localization = index.localization
            routeViewController.provider = provider
            routeViewController.route = route
        }
    }
    
    // MARK: ViewController
    override func handleTimeChange() {
        super.handleTimeChange()
        
        guard let date: Date = date, date > Date(timeIntervalSinceNow: -3600.0 * 8.0) else {
            reloadIndex()
            return
        }
        guard let tableView: UITableView = tableView,
            let toolbar: IndexToolbar = toolbar else {
            return
        }
        toolbar.index = index
        tableView.reloadData()
        scrollViewDidScroll(tableView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        handleTimeChange()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleTimeChange()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.refreshControl = UIRefreshControl()
        tableView?.refreshControl?.addTarget(self, action: #selector(reloadIndex), for: UIControl.Event.valueChanged)
        tableView?.separatorStyle = .none
    }
    
    override func transitionMode(duration: TimeInterval) {
        super.transitionMode(duration: duration)
        
        tableView?.indicatorStyle = mode.indicatorStyle
        for cell in tableView?.visibleCells ?? [] {
            (cell as? ModeTransitioning)?.transitionMode(duration: duration)
        }
        toolbar?.transitionMode(duration: duration)
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return index?.sorted.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IndexViewCell = tableView.dequeueReusableCell(withIdentifier: "Index") as! IndexViewCell
        cell.localization = index?.localization
        cell.provider = index?.sorted[indexPath.row].provider
        cell.route = index?.sorted[indexPath.row].route
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IndexViewCell.height(for: tableView.bounds.size.width)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return max((tableView.bounds.size.height - tableView.safeAreaInsets.height) - (CGFloat(index?.sorted.count ?? 0) * IndexViewCell.height(for: tableView.bounds.size.width)), 242.0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = UIView()
        view.isUserInteractionEnabled = false
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let routeViewController: RouteViewController = storyboard?.instantiateViewController(withIdentifier: "Route") as? RouteViewController,
            let localization: Localization = index?.localization,
            let routes: [(route: Route, provider: Provider)] = index?.sorted, routes.count > indexPath.row else {
            return
        }
        routeViewController.localization = localization
        routeViewController.provider = routes[indexPath.row].provider
        routeViewController.route = routes[indexPath.row].route
        DispatchQueue.main.async {
            self.present(routeViewController, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView: UITableView = tableView,
            let toolbar: IndexToolbar = toolbar else {
            return
        }
        let height: CGFloat = view.safeAreaInsets.top + toolbar.intrinsicContentSize.height
        let y: CGFloat = view.safeAreaInsets.top + scrollView.contentOffset.y
        
        tableView.scrollIndicatorInsets.top = max(0.0, toolbar.intrinsicContentSize.height + min(0.0, y))
        toolbar.frame.size.height = max(height, height - y)
        toolbar.isBackgroundHidden = y < 1.0 + max(self.tableView(tableView, heightForHeaderInSection: 0) + view.safeAreaInsets.top - toolbar.frame.size.height, 0.0)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollViewDidScroll(scrollView)
    }
}
