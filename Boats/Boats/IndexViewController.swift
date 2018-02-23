import UIKit
import BoatsKit

class IndexViewController: ViewController, UITableViewDataSource, UITableViewDelegate, RouteViewAnimatorDelegate {
    private let url: URL = URL(string: "https://toddheasley.github.io/boats/index.json")!
    private var selectedIndexPath: IndexPath?
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var toolbar: IndexToolbar?
    
    private(set) var index: Index? {
        didSet {
            handleTimeChange()
        }
    }
    
    @objc func reloadIndex() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Index.read(from: url) { index, error in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.tableView?.refreshControl?.endRefreshing()
            self.index = index
        }
    }
    
    // MARK: ViewController
    override func handleTimeChange() {
        super.handleTimeChange()
        
        guard let tableView = tableView,
            let toolbar = toolbar else {
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
        
        reloadIndex()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.refreshControl = UIRefreshControl()
        tableView?.refreshControl?.addTarget(self, action: #selector(reloadIndex), for: .valueChanged)
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
        return index?.routes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IndexViewCell = tableView.dequeueReusableCell(withIdentifier: "Index") as! IndexViewCell
        cell.localization = index?.localization
        cell.provider = index?.routes[indexPath.row].provider
        cell.route = index?.routes[indexPath.row].route
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IndexViewCell.height(for: tableView.bounds.size.width)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return max((tableView.bounds.size.height - tableView.safeAreaInsets.size.height) - (CGFloat(index?.routes.count ?? 0) * IndexViewCell.height(for: tableView.bounds.size.width)), 242.0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let routeViewController = storyboard?.instantiateViewController(withIdentifier: "Route") as? RouteViewController,
            let localization = index?.localization,
            let routes = index?.routes, routes.count > indexPath.row else {
            selectedIndexPath = nil
            return
        }
        selectedIndexPath = indexPath
        
        routeViewController.localization = localization
        routeViewController.provider = routes[indexPath.row].provider
        routeViewController.route = routes[indexPath.row].route
        routeViewController.delegate = self
        
        DispatchQueue.main.async {
            self.present(routeViewController, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = tableView,
            let toolbar = toolbar else {
            return
        }
        let height: CGFloat = view.safeAreaInsets.top + toolbar.intrinsicContentSize.height
        let y = view.safeAreaInsets.top + scrollView.contentOffset.y
        
        tableView.scrollIndicatorInsets.top = max(0.0, toolbar.intrinsicContentSize.height + min(0.0, y))
        toolbar.frame.size.height = max(height, height - y)
        toolbar.isBackgroundHidden = y < 1.0 + max(self.tableView(tableView, heightForHeaderInSection: 0) + view.safeAreaInsets.top - toolbar.frame.size.height, 0.0)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollViewDidScroll(scrollView)
    }
    
    // MARK: RouteViewAnimatorDelegate
    func routeViewAnimatorTargetRect(controller: RouteViewController) -> CGRect? {
        return nil
    }
    
    func routeViewDidFinish(controller: RouteViewController) {
        dismiss(animated: true)
    }
}
