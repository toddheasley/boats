//
//  MainTableViewController.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit
import BoatsData

class MainTableViewController: UITableViewController {
    func refresh(sender: AnyObject?) {
        refreshControl?.beginRefreshing()
        Data.sharedData.reloadData { completed in
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            if let presentedViewController = self.presentedViewController as? RouteViewController {
                presentedViewController.viewWillAppear(true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "RouteTableViewCell")
        tableView.contentInset = UIEdgeInsetsMake(UIApplication.sharedApplication().statusBarFrame.size.height, 0.0, 0.0, 0.0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.tableHeaderView = MainTableHeaderView(frame: CGRectMake(0.0, 0.0, view.bounds.size.width, 102.0))
        tableView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.975)
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(MainTableViewController.refresh(_:)), forControlEvents: .ValueChanged)
        refresh(self)
    }
    
    required init() {
        super.init(style: .Grouped)
    }
    
    override init(style: UITableViewStyle) {
        fatalError("init(style:) has not been implemented")
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let refreshControl = refreshControl where !refreshControl.refreshing else {
            return 0
        }
        return Data.sharedData.providers.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.sharedData.providers[section].routes.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Data.sharedData.providers[section].name
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RouteTableViewCell", forIndexPath: indexPath)
        cell.textLabel?.text = Data.sharedData.providers[indexPath.section].routes[indexPath.row].name
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        presentViewController(RouteViewController(route: Data.sharedData.providers[indexPath.section].routes[indexPath.row]), animated: true){
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewCell().intrinsicContentSize().height
    }
}
