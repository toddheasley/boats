//
//  DeparturesTableViewController.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit

class DeparturesTableViewController: UITableViewController {
    var departures: [Departure] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .None
        tableView.registerClass(DepartureTableViewCell.self, forCellReuseIdentifier: "DepartureTableViewCell")
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departures.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DepartureTableViewCell", forIndexPath: indexPath)
        cell.textLabel?.text = departures[indexPath.row].time.JSON as? String
        return cell
    }
}
