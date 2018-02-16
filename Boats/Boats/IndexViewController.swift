import UIKit
import BoatsKit

class IndexViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    private let url: URL = URL(string: "https://toddheasley.github.io/boats/index.json")!
    
    @IBOutlet var tableView: UITableView?
    
    var index: Index? {
        didSet {
            (tableView?.tableHeaderView as? IndexView)?.index = index
            tableView?.reloadData()
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        
        
        transitionMode(duration: 0.0)
    }
    
    override func transitionMode(duration: TimeInterval) {
        super.transitionMode(duration: duration)
        
        (tableView?.tableHeaderView as? ModeTransitioning)?.transitionMode(duration: duration)
        for cell in tableView?.visibleCells ?? [] {
            (cell as? ModeTransitioning)?.transitionMode(duration: duration)
        }
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return index?.routes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Route")!
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
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
