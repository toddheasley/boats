//
//  ScheduleView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class ScheduleView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let dayView: DayView = DayView()
    private let departureCell: DepartureCell = DepartureCell()
    private var days: [(day: Day, departures: [Departure])] = []
    private(set) var direction: Direction = .destination
    
    var schedule: Schedule? {
        didSet {
            guard let schedule = schedule else {
                days = []
                return
            }
            days = schedule.days.map { day in
                (day, schedule.departures(day: day, direction: direction))
            }
            reloadData()
        }
    }
    
    var style: DepartureCellStyle {
        return (bounds.size.width < 568.0) ? .table : .collection
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
        cell.status = .past
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0.0, height: dayView.intrinsicContentSize.height + layoutEdgeInsets.top)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch style {
        case .collection:
            return departureCell.intrinsicContentSize
        case .table:
            return CGSize(width: collectionView.bounds.size.width, height: departureCell.intrinsicContentSize.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return layoutEdgeInsets.top
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return layoutEdgeInsets
    }
}
