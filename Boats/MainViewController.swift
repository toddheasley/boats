//
//  MainViewController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class MainViewController: ViewController, UITableViewDataSource, UITableViewDelegate, RouteViewDelegate {
    private let mainViewCell: MainViewCell = MainViewCell()
    private let routeViewCell: RouteViewCell = RouteViewCell()
    private var selectedIndexPath: IndexPath?
    var tableView: UITableView!
    
    override func dataDidRefresh(completed: Bool) {
        super.dataDidRefresh(completed: completed)
        tableView.refreshControl?.endRefreshing()
        if completed {
            tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(MainViewCell.self, forCellReuseIdentifier: "MainViewCell")
        tableView.register(RouteViewCell.self, forCellReuseIdentifier: "RouteViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .none
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidLayoutSubviews()
        if tableView.numberOfSections < 2 {
            refreshData()
        }
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + data.providers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return data.providers[section - 1].routes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell") as! MainViewCell
            cell.nameText = data.name
            cell.descriptionText = data.description
            return cell
        default:
            let provider = data.providers[indexPath.section - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteViewCell") as! RouteViewCell
            cell.provider = provider
            cell.route = provider.routes[indexPath.row]
            return cell
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        routeViewCell.frame = tableView.bounds
        routeViewCell.layoutSubviews()
        let height: CGFloat = routeViewCell.intrinsicContentSize.height + tableView.layoutEdgeInsets.top + tableView.layoutEdgeInsets.bottom
        switch indexPath.section {
        case 0:
            let minimum: CGFloat = mainViewCell.intrinsicContentSize.height + (tableView.layoutEdgeInsets.top + tableView.layoutEdgeInsets.bottom * 3.0)
            let available: CGFloat = tableView.bounds.size.height - (tableView.contentInset.top + tableView.contentInset.bottom)
            var count: CGFloat = 0.0
            for provider in data.providers {
                count += CGFloat(provider.routes.count)
            }
            return max(available - (min(floor((available - minimum) / height), count) * height), minimum)
        default:
            return height
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        default:
            selectedIndexPath = indexPath
            guard let cell = tableView.cellForRow(at: indexPath) as? RouteViewCell, let routeViewController =
                RouteViewController(provider: cell.provider, route: cell.route) else {
                return
            }
            navigationController?.pushViewController(routeViewController, animated: true)
        }
    }
    
    // MARK: RouteViewDelegate
    func routeViewRect(controller: RouteViewController) -> CGRect? {
        guard let selectedIndexPath = selectedIndexPath else {
            return nil
        }
        var rect = tableView.rectForRow(at: selectedIndexPath)
        rect.origin.y -= tableView.contentOffset.y
        return rect
    }
}
