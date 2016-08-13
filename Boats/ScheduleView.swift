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
    private let dayView: DayView = DayView()
    private let departureCell: DepartureCell = DepartureCell()
    private var time: Time = Time()
    private var day: Day = .everyday
    private var days: [(day: Day, departures: [Departure])] = []
    private var departures: (next: Departure?, last: Departure?) = (nil, nil)
    private(set) var direction: Direction = .destination
    
    private var style: DepartureCellStyle {
        return (bounds.size.width < 568.0) ? .table : .collection
    }
    
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
    
    private func status(day: Day, departure: Departure) -> Status {
        if day != self.day || departure.time <= time {
            return .past
        } else if let last = departures.last, last.time == departure.time {
            return .last
        } else if let next = departures.next, next.time == departure.time {
            return .next
        }
        return .soon
    }
    
    private func indexPath(day: Day, departure: Departure?) -> IndexPath? {
        if day != .everyday, let departure = departure {
            for (section, object) in days.enumerated() {
                if (object.day != day) {
                    continue
                }
                for (item, object) in object.departures.enumerated() {
                    if object.time != departure.time {
                        continue
                    }
                    return IndexPath(item: item, section: section)
                }
            }
        }
        return nil
    }
    
    private func scroll(animated: Bool) {
        guard let indexPath = indexPath(day: day, departure: departures.next), canScroll else {
            canScroll = true
            return
        }
        scrollToItem(at: indexPath, at: .centeredVertically, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    convenience init(direction: Direction) {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.direction = direction
        
        (self.collectionViewLayout as! UICollectionViewFlowLayout).sectionHeadersPinToVisibleBounds = true
        
        backgroundColor = .none
        register(DayView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DayView")
        register(DepartureCell.self, forCellWithReuseIdentifier: "DepartureCell")
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
        view.day = days[indexPath.section].day
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "DepartureCell", for: indexPath) as! DepartureCell
        cell.style = style
        cell.departure = days[indexPath.section].departures[indexPath.row]
        cell.status = status(day: days[indexPath.section].day, departure: days[indexPath.section].departures[indexPath.row])
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0.0, height: dayView.intrinsicContentSize.height + layoutInterItemSpacing.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch style {
        case .collection:
            let numberOfColumns: Int = bounds.size.width < 568.0 ? 1 : (bounds.size.width < 1024.0 ? 2 : 3)
            let width: CGFloat = floor((bounds.size.width - (layoutEdgeInsets.left * CGFloat(numberOfColumns + 1))) / CGFloat(numberOfColumns))
            return CGSize(width: max(width , departureCell.intrinsicContentSize.width), height: departureCell.intrinsicContentSize.height + layoutInterItemSpacing.height)
        case .table:
            return CGSize(width: collectionView.bounds.size.width, height: departureCell.intrinsicContentSize.height + layoutInterItemSpacing.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return layoutInterItemSpacing.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var edgeInsets = style == .collection ? layoutEdgeInsets : .zero
        edgeInsets.top = layoutInterItemSpacing.height
        return edgeInsets
    }
    
    // MARK: UIScrollviewDelegate
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        canScroll = false
    }
}
