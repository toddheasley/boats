//
//  ScheduleView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class ScheduleView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var canScroll: Bool = true
    private var time: Time = Time()
    private var day: Day = .everyday
    private var days: [(day: Day, departures: [Departure])] = []
    private var departures: (next: Departure?, last: Departure?) = (nil, nil)
    private(set) var direction: Direction = .destination
    
    var schedule: Schedule? {
        didSet {
            time = Time()
            day = schedule?.day ?? .everyday
            days = []
            if let schedule = schedule {
                days = schedule.days.map { day in
                    (day, schedule.departures(day: day, direction: direction))
                }
            }
            departures.last = schedule?.departures(direction: direction).last
            departures.next = schedule?.departure(direction: direction)
            reloadData()
            scroll(animated: true)
        }
    }
    
    var color: UIColor = UILabel().textColor {
        didSet {
            reloadData()
        }
    }
    
    override var frame: CGRect {
        didSet {
            reloadData()
            scroll(animated: true)
        }
    }
    
    private func status(day: Day, departure: Departure) -> DepartureStatus {
        if day != self.day || departure.time <= time {
            return .past
        } else if let next = departures.next, next.time == departure.time {
            return .next
        } else if let last = departures.last, last.time == departure.time {
            return .last
        }
        return .soon
    }
    
    private func indexPath(day: Day, departure: Departure?) -> IndexPath? {
        if day != .everyday {
            for (section, object) in days.enumerated() {
                guard object.day == day else {
                    continue
                }
                let departures: [Departure] = object.departures
                for (item, object) in departures.enumerated() {
                    if object.time == departure?.time || object.time == departures.last?.time {
                        return IndexPath(item: item, section: section)
                    }
                }
                return IndexPath(item: 0, section: section)
            }
        }
        return nil
    }
    
    private func scroll(animated: Bool) {
        guard let indexPath = indexPath(day: day, departure: departures.next), canScroll else {
            return
        }
        scrollToItem(at: indexPath, at: .centeredVertically, animated: animated)
    }
    
    convenience init(direction: Direction = .destination) {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        (self.collectionViewLayout as! UICollectionViewFlowLayout).sectionHeadersPinToVisibleBounds = true
        
        self.direction = direction
        
        backgroundColor = .clear
        register(DayView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DayView")
        register(DepartureViewCell.self, forCellWithReuseIdentifier: "DepartureViewCell")
        dataSource = self
        delegate = self
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days[section].departures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DayView", for: indexPath) as! DayView
        view.color = color
        view.day = days[indexPath.section].day
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "DepartureViewCell", for: indexPath) as! DepartureViewCell
        cell.color = color
        cell.departure = days[indexPath.section].departures[indexPath.row]
        cell.status = status(day: days[indexPath.section].day, departure: days[indexPath.section].departures[indexPath.row])
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: traitCollection.verticalSizeClass == .compact ? 26.0 : 34.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: Int = bounds.size.width < 568.0 ? 1 : (bounds.size.width < 1024.0 ? 2 : 3)
        let width: CGFloat = floor((bounds.size.width - (32.0 * CGFloat(numberOfColumns))) / CGFloat(numberOfColumns))
        return CGSize(width: width, height: 56.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 16.0, bottom: traitCollection.verticalSizeClass == .compact ? 4.0 : 8.0, right: 16.0)
    }
    
    // MARK: UIScrollviewDelegate
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        canScroll = false
    }
}
