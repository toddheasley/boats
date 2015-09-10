//
//  MainTableViewController.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit

class MainTableViewController: UITableViewController {
    var data: Data = Data()
    
    func refresh(sender: AnyObject?) {
        if (sender == nil) {
            refreshControl?.beginRefreshing()
        }
        data.refresh{ error in
            dispatch_async(dispatch_get_main_queue()){
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(MainRouteTableViewCell.self, forCellReuseIdentifier: "MainRouteTableViewCell")
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        refresh(nil)
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : data.routes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section > 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("MainRouteTableViewCell", forIndexPath: indexPath)
            cell.textLabel?.text = data.routes[indexPath.row].name
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("MainRouteTableViewCell", forIndexPath: indexPath)
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 1) {
            presentViewController(RouteViewController(route: data.routes[indexPath.row]), animated: true){
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
}
