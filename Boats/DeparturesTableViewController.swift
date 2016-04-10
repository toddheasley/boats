//
//  DeparturesTableViewController.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit
import BoatsData

enum DepartureStatus: Int {
    case Past = -1
    case Current = 0
    case Future = 1
}

class DeparturesTableViewController: UITableViewController {
    private var dateFormatter: NSDateFormatter = NSDateFormatter()
    
    var departures: [Departure] = [] {
        didSet {
            tableView.reloadData()
            updateScrollPosition(true)
        }
    }
    
    var currentDeparture: (departure: Departure, index: Int)? {
        if let time = Time(date: NSDate()) {
            for (index, departure) in departures.enumerate() {
                if (time > departure.time) {
                    continue
                }
                return (departure: departure, index: index)
            }
        }
        return nil
    }
    
    func status(departure: Departure) -> DepartureStatus {
        guard let time = Time() where time <= departure.time else {
            return .Past
        }
        if let currentDeparture = currentDeparture where departure.time == currentDeparture.departure.time {
            return .Current
        }
        return .Future
    }
    
    private func updateScrollPosition(animated: Bool) {
        guard let departure = currentDeparture else {
            return
        }
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: departure.index, inSection: 0), atScrollPosition: .Top, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(DepartureTableViewCell.self, forCellReuseIdentifier: "DepartureTableViewCell")
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateScrollPosition(false)
    }
    
    override init(style: UITableViewStyle = UITableViewStyle.Plain) {
        super.init(style: style)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departures.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DepartureTableViewCell", forIndexPath: indexPath) as! DepartureTableViewCell
        cell.departure = departures[indexPath.row]
        cell.status = status(departures[indexPath.row])
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return DepartureTableViewCell.height
    }
}
