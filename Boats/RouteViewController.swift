//
//  RouteViewController.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit

class RouteViewController: UIViewController, UIScrollViewDelegate {
    private var route: Route?
    private var departuresTableViewControllers: [DeparturesTableViewController]!
    private var departuresView: UIScrollView!
    private var departuresSegmentedControl: UISegmentedControl!
    private var detailView: UIVisualEffectView!
    private var dismissButton: UIButton!
    private var nameLabel: UILabel!
    private var seasonLabel: UILabel!
    private var dateLabel: UILabel!
    
    private var direction: Direction = .Destination {
        didSet {
            departuresSegmentedControl.selectedSegmentIndex = (direction == .Destination) ? 0 : 1
            departuresView.setContentOffset(CGPointMake((direction == .Destination) ? 0.0 : departuresView.bounds.size.width, 0.0), animated: view.window != nil)
        }
    }
    
    func dismiss(sender: AnyObject?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func changeDirection(sender: AnyObject?) {
        switch departuresSegmentedControl.selectedSegmentIndex {
        case 1:
            direction = .Origin
        default:
            direction = .Destination
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        departuresView = UIScrollView(frame: view.bounds)
        departuresView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        departuresView.showsHorizontalScrollIndicator = false
        departuresView.showsVerticalScrollIndicator = false
        departuresView.bounces = false
        departuresView.pagingEnabled = true
        departuresView.delegate = self
        view.addSubview(departuresView)
        
        departuresTableViewControllers = [
            DeparturesTableViewController(),
            DeparturesTableViewController()
        ]
        departuresTableViewControllers[0].tableView.contentInset = UIEdgeInsetsMake(141.0, 0.0, 0.0, 0.0)
        departuresTableViewControllers[1].tableView.contentInset = departuresTableViewControllers[0].tableView.contentInset
        departuresTableViewControllers[0].tableView.scrollIndicatorInsets = departuresTableViewControllers[0].tableView.contentInset
        departuresTableViewControllers[1].tableView.scrollIndicatorInsets = departuresTableViewControllers[0].tableView.contentInset
        departuresView.addSubview(departuresTableViewControllers[0].view)
        departuresView.addSubview(departuresTableViewControllers[1].view)
        
        detailView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
        detailView.frame = CGRectMake(0.0, 0.0, view.bounds.size.width, 141.0)
        detailView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        view.addSubview(detailView)
        
        let layer = CALayer()
        layer.frame = CGRectMake(0.0, detailView.bounds.size.height - 0.5, detailView.bounds.size.width, 0.5)
        layer.backgroundColor = UIColor.lightGrayColor().CGColor
        detailView.layer.addSublayer(layer)
        
        nameLabel = UILabel(frame: CGRectMake(65.0, 33.0, detailView.bounds.size.width - 130.0, 19.0))
        nameLabel.autoresizingMask = [.FlexibleWidth]
        nameLabel.font = UIFont.boldSystemFontOfSize(15.0)
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .Center
        detailView.contentView.addSubview(nameLabel)
        
        dateLabel = UILabel(frame: CGRectMake(15.0, 53.0, view.bounds.size.width - 30.0, 41.0))
        dateLabel.autoresizingMask = [.FlexibleWidth]
        dateLabel.font = UIFont.systemFontOfSize(17.0)
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .Center
        dateLabel.alpha = 0.8
        detailView.contentView.addSubview(dateLabel)
        
        dismissButton = UIButton()
        dismissButton.titleLabel?.font = UIFont.boldSystemFontOfSize(15.0)
        dismissButton.setTitleColor(dismissButton.tintColor, forState: .Normal)
        dismissButton.setTitle("Done", forState: .Normal)
        dismissButton.sizeToFit()
        dismissButton.frame = CGRectMake(view.bounds.size.width - 61.0, 20.0, 65.0, 45.0)
        dismissButton.autoresizingMask = [.FlexibleLeftMargin]
        dismissButton.addTarget(self, action: "dismiss:", forControlEvents: .TouchUpInside)
        detailView.contentView.addSubview(dismissButton)
        
        departuresSegmentedControl = UISegmentedControl(items: ["", ""])
        departuresSegmentedControl.frame = CGRectMake(10.0, detailView.bounds.size.height - departuresSegmentedControl.frame.size.height - 12.0, detailView.bounds.size.width - 20.0, departuresSegmentedControl.frame.size.height)
        departuresSegmentedControl.autoresizingMask = [.FlexibleWidth]
        departuresSegmentedControl.selectedSegmentIndex = 0
        departuresSegmentedControl.addTarget(self, action: "changeDirection:", forControlEvents: .ValueChanged)
        detailView.contentView.addSubview(departuresSegmentedControl)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameLabel.text = ""
        dateLabel.text = ""
        departuresSegmentedControl.hidden = true
        if let route = route {
            nameLabel.text = route.name
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = Date.format
            guard let date = Date(JSON: dateFormatter.stringFromDate(NSDate())), let schedule = route.schedule(date) else {
                return
            }
            dateFormatter.dateFormat = "EE, MMM d"
            dateLabel.text = "\(schedule.season.rawValue) Schedule: \(dateFormatter.stringFromDate(NSDate()))"
            departuresSegmentedControl.setTitle("From \(route.origin.name)", forSegmentAtIndex: 0)
            departuresSegmentedControl.setTitle("To \(route.origin.name)", forSegmentAtIndex: 1)
            departuresSegmentedControl.hidden = false
            dateFormatter.dateFormat = Day.format
            var day: Day = .Everyday
            if let _ = Day(rawValue: dateFormatter.stringFromDate(NSDate())) {
                day = Day(rawValue: dateFormatter.stringFromDate(NSDate()))!
            }
            for holiday in schedule.holidays {
                if (holiday.date.value == date.value) {
                    day = .Holiday
                    dateFormatter.dateFormat = "EE, MMM d"
                    dateLabel.text = "\(Day.Holiday.rawValue) Schedule: \(dateFormatter.stringFromDate(NSDate())) (\(holiday.name))"
                }
            }
            departuresTableViewControllers[0].departures = schedule.departures(day, direction: .Destination)
            departuresTableViewControllers[1].departures = schedule.departures(day, direction: .Origin)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        departuresView.contentSize = CGSizeMake(departuresView.bounds.size.width * 2.0, departuresView.bounds.size.height)
        departuresTableViewControllers[0].view.frame = departuresView.bounds
        departuresTableViewControllers[1].view.frame = CGRectMake(departuresView.bounds.size.width, 0.0, departuresView.bounds.size.width, departuresView.bounds.size.height)
    }
    
    convenience init(route: Route) {
        self.init()
        
        self.route = route
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        direction = (departuresView.contentOffset.x > 0.0) ? .Origin : .Destination
    }
}