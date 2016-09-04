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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func dataDidRefresh() {
        super.dataDidRefresh()
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    override func modeDidChange() {
        super.modeDidChange()
        tableView.separatorColor = UIColor.foreground(mode: mode).withAlphaComponent(0.2)
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
            cell.nameLabel.textColor = .foreground(mode: mode)
            cell.nameLabel.text = "\(data.name)"
            cell.descriptionLabel.textColor = cell.nameLabel.textColor
            cell.descriptionLabel.text = "\(data.description)"
            return cell
        default:
            let provider = data.providers[indexPath.section - 1]
            let route = provider.routes[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteViewCell") as! RouteViewCell
            cell.routeLabel.textColor = .foreground(mode: mode)
            cell.routeLabel.text = "\(route.name)"
            cell.originLabel.textColor = cell.routeLabel.textColor
            cell.originLabel.text = "From \(route.origin.name)"
            cell.departureView.color = cell.routeLabel.textColor
            cell.departureView.departure = route.schedule()?.departure()
            cell.departureView.status = .next
            cell.providerLabel.textColor = cell.routeLabel.textColor
            cell.providerLabel.text = "Operated by \(provider.name)"
            return cell
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight: CGFloat = (tableView.bounds.size.width > 480.0 ? 76.0 : 122.0) + (traitCollection.verticalSizeClass == .compact ? 16.0 : 28.0)
        switch indexPath.section {
        case 0:
            let minimumRowHeight: CGFloat = self.traitCollection.verticalSizeClass == .compact ? 50.0 : 66.0
            let availableContentHeight: CGFloat = tableView.bounds.size.height - (tableView.contentInset.top + tableView.contentInset.bottom)
            var rowCount: CGFloat = 0.0
            for provider in data.providers {
                rowCount += CGFloat(provider.routes.count)
            }
            return max(availableContentHeight - (min(floor((availableContentHeight - minimumRowHeight) / rowHeight), rowCount) * rowHeight), minimumRowHeight)
        default:
            return rowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section > 0, let routeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Route") as? RouteViewController else {
            selectedIndexPath = nil
            return
        }
        selectedIndexPath = indexPath
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
