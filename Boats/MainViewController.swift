//
//  MainViewController.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class MainViewController: ViewController, UITableViewDataSource, UITableViewDelegate, RouteViewDelegate {
    private var selectedIndexPath: IndexPath?
    
    @IBOutlet var tableView: UITableView!
    
    override func dataDidRefresh() {
        super.dataDidRefresh()
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    override func modeDidChange() {
        super.modeDidChange()
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
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
            cell.backgroundColor = view.backgroundColor
            //cell.nameLabel.textColor = .purple
            cell.nameLabel.text = "\(data.name)"
            //cell.descriptionLabel.textColor = .purple
            cell.descriptionLabel.text = "\(data.description)"
            return cell
        default:
            let provider = data.providers[indexPath.section - 1]
            let route = provider.routes[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteViewCell") as! RouteViewCell
            cell.routeLabel.textColor = .purple
            cell.routeLabel.text = "\(route.name)"
            cell.originLabel.textColor = .purple
            cell.originLabel.text = "From \(route.origin.name)"
            cell.providerLabel.textColor = .purple
            cell.providerLabel.text = "Operated by \(provider.name)"
            return cell
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93.0
        
        /*
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
        */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        guard indexPath.section > 0, let routeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Route") as? RouteViewController else {
            return
        }
        let provider = data.providers[indexPath.section - 1]
        routeViewController.provider = provider
        routeViewController.route = provider.routes[indexPath.row]
        navigationController?.delegate = routeViewController
        navigationController?.pushViewController(routeViewController, animated: true)
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
