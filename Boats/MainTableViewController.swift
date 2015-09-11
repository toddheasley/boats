//
//  MainTableViewController.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit

class MainTableViewController: UITableViewController {
    var data: Data = Data(local: true)
    
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
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "RouteTableViewCell")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        refresh(nil)
    }
    
    required init() {
        super.init(style: UITableViewStyle.Grouped)
    }
    
    override init(style: UITableViewStyle) {
        fatalError("init(style:) has not been implemented")
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.providers.count + 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : data.providers[section - 1].routes.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? nil : data.providers[section - 1].name
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section > 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("RouteTableViewCell", forIndexPath: indexPath)
            cell.textLabel?.text = data.providers[indexPath.section - 1].routes[indexPath.row].name
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section > 0) {
            presentViewController(RouteViewController(route: data.providers[indexPath.section - 1].routes[indexPath.row]), animated: true){
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (indexPath.section == 0) ? 221.0 : UITableViewCell().intrinsicContentSize().height
    }
}
