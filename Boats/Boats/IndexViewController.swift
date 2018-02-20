import UIKit
import BoatsKit

class IndexViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    private let url: URL = URL(string: "https://toddheasley.github.io/boats/index.json")!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var toolbar: IndexToolbar!
    
    var index: Index? {
        didSet {
            handleTimeChange()
        }
    }
    
    @objc func reloadIndex() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Index.read(from: url) { index, error in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.tableView.refreshControl?.endRefreshing()
            self.index = index
        }
    }
    
    // MARK: ViewController
    override func handleTimeChange() {
        super.handleTimeChange()
        
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
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadIndex), for: .valueChanged)
        tableView.separatorStyle = .none
        
        transitionMode(duration: 0.0)
    }
    
    override func transitionMode(duration: TimeInterval) {
        super.transitionMode(duration: duration)
        
        tableView.indicatorStyle = mode.indicatorStyle
        for cell in tableView?.visibleCells ?? [] {
            (cell as? ModeTransitioning)?.transitionMode(duration: duration)
        }
        toolbar.transitionMode(duration: duration)
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
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height: CGFloat = view.safeAreaInsets.top + toolbar.intrinsicContentSize.height
        let y = view.safeAreaInsets.top + scrollView.contentOffset.y
        
        tableView.scrollIndicatorInsets.top = max(0.0, toolbar.intrinsicContentSize.height + min(0.0, y))
        toolbar.frame.size.height = max(height, height - y)
        toolbar.isBackgroundHidden = y < 1.0 + max(tableView(tableView, heightForHeaderInSection: 0) + view.safeAreaInsets.top - toolbar.frame.size.height, 0.0)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollViewDidScroll(scrollView)
    }
}

extension UserDefaults {
    static var route: (uri: URI, direction: Departure.Direction)? {
        set {
            if let newValue = newValue {
                standard.set("\(newValue.uri):\(newValue.direction.rawValue)", forKey: "route")
            } else {
                standard.removeObject(forKey: "route")
            }
        }
        get {
            guard let components = standard.string(forKey: "route")?.components(separatedBy: ":"), components.count == 2,
                let direction = Departure.Direction(rawValue: components[1]) else {
                return nil
            }
            return (URI(resource: components[0]), direction)
        }
    }
}
