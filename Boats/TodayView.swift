//
//  TodayView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class TodayView: RouteView {
    private let directionControl: DirectionControl = DirectionControl()
    private let todayLabel: TodayLabel = TodayLabel()
    private let destinationView: DeparturesView = DeparturesView()
    private let originView: DeparturesView = DeparturesView()
    private var day: Day = .everyday
    
    override var route: Route? {
        didSet {
            guard let route = route, let schedule = route.schedule() else {
                directionControl.origin = nil
                todayLabel.holiday = nil
                destinationView.departures = []
                originView.departures = []
                day = .everyday
                return
            }
            directionControl.origin = route.origin
            todayLabel.holiday = nil
            let date = Date()
            day = Day()
            for holiday in schedule.holidays {
                if (holiday.date == date) {
                    todayLabel.holiday = holiday
                    day = .holiday
                    break
                }
            }
            destinationView.departures = schedule.departures(day: day, direction: .destination)
            originView.departures = schedule.departures(day: day, direction: .origin)
        }
    }
    
    override var page: (index: Int, count: Int) {
        didSet {
            directionControl.selectedSegmentIndex = page.index
        }
    }
    
    func changeDirection(sender: AnyObject?) {
        scrollView.setContentOffset(CGPoint(x: (scrollView.bounds.size.width * CGFloat(directionControl.selectedSegmentIndex)), y: 0.0), animated: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        todayLabel.frame.size.width = suggestedFrame.size.width
        todayLabel.frame.size.height = todayLabel.intrinsicContentSize().height
        todayLabel.frame.origin.x = suggestedFrame.origin.x
        todayLabel.frame.origin.y = 0.0
        
        directionControl.frame.size.width = suggestedFrame.size.width
        directionControl.frame.origin.x = suggestedFrame.origin.x
        directionControl.frame.origin.y = todayLabel.frame.size.height + 7.0
        
        scrollView.frame.origin.y = directionControl.frame.origin.y + directionControl.frame.size.height + 14.0
        scrollView.frame.size.height = bounds.size.height - scrollView.frame.origin.y
        
        destinationView.frame.size = scrollView.bounds.size
        destinationView.frame.origin = .zero
        
        originView.frame = destinationView.frame
        originView.frame.origin.x = originView.frame.size.width
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        routeControl.text = "Today"
        page.count = 2
        
        todayLabel.frame.size = todayLabel.intrinsicContentSize()
        addSubview(todayLabel)
        
        directionControl.addTarget(self, action: #selector(changeDirection(sender:)), for: .valueChanged)
        addSubview(directionControl)
        
        scrollView.addSubview(destinationView)
        scrollView.addSubview(originView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
