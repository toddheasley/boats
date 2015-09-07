//
//  RouteViewController.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit

class RouteViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var dismissControl: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var departuresView: UIScrollView!
    @IBOutlet var departuresSegmentedControl: UISegmentedControl!
    private var departuresTableViewControllers: [DeparturesTableViewController]!
    private var route: Route?
    
    private var direction: Direction = .Destination {
        didSet {
            departuresSegmentedControl.selectedSegmentIndex = (direction == .Destination) ? 0 : 1
            departuresView.setContentOffset(CGPointMake((direction == .Destination) ? 0.0 : departuresView.bounds.size.width, 0.0), animated: view.window != nil)
        }
    }
    
    @IBAction func dismiss(sender: AnyObject?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func changeDirection(sender: AnyObject?) {
        switch departuresSegmentedControl.selectedSegmentIndex {
        case 1:
            direction = .Origin
        default:
            direction = .Destination
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        departuresTableViewControllers = [
            DeparturesTableViewController(),
            DeparturesTableViewController()
        ]
        departuresView.addSubview(departuresTableViewControllers[0].view)
        departuresView.addSubview(departuresTableViewControllers[1].view)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = ""
        seasonLabel.text = ""
        seasonLabel.hidden = true
        dateLabel.text = ""
        if let route = route {
            nameLabel.text = route.name
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = Date.format
            guard let date = Date(JSON: dateFormatter.stringFromDate(NSDate())), let schedule = route.schedule(date) else {
                return
            }
            nameLabel.text = route.name
            seasonLabel.text = " \(schedule.season.rawValue) "
            seasonLabel.hidden = false
            dateFormatter.dateFormat = "EEEE, MMMM d"
            dateLabel.text = dateFormatter.stringFromDate(NSDate())
            departuresSegmentedControl.setTitle("From \(route.origin.name)", forSegmentAtIndex: 0)
            departuresSegmentedControl.setTitle("To \(route.origin.name)", forSegmentAtIndex: 1)
            departuresTableViewControllers[0].departures = schedule.departures(.Everyday, direction: .Destination)
            departuresTableViewControllers[1].departures = schedule.departures(.Everyday, direction: .Origin)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        departuresView.contentSize = CGSizeMake(departuresView.bounds.size.width * 2.0, departuresView.bounds.size.height)
        departuresTableViewControllers[0].view.frame = departuresView.bounds
        departuresTableViewControllers[1].view.frame = CGRectMake(departuresView.bounds.size.width, 0.0, departuresView.bounds.size.width, departuresView.bounds.size.height)
    }
    
    convenience init(route: Route) {
        self.init(nibName: "RouteView", bundle: nil)
        self.route = route
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        direction = (departuresView.contentOffset.x > 0.0) ? .Origin : .Destination
    }
}
