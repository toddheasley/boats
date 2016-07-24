//
//  DeparturesView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class DeparturesView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var canScroll: Bool = true
    private var time: Time = Time()
    private var status: [Status] = []
    
    private var next: (departure: Departure, index: Int)? {
        for (index, departure) in departures.enumerated() {
            if (departure.time > time) {
                return (departure, index)
            }
        }
        return nil
    }
    
    var departures: [Departure] = [] {
        didSet {
            time = Time()
            status = departures.map { departure in
                if let last = departures.last, departure.time == last.time {
                    return .last
                } else if let next = next, departure.time == next.departure.time {
                    return .next
                }
                return (departure.time > time) ? .future : .past
            }
            reloadData()
            scroll(animated: true)
        }
    }
    
    private func scroll(animated: Bool) {
        guard let next = next, canScroll else {
            canScroll = true
            return
        }
        scrollToItem(at: IndexPath(item: next.index, section: 0), at: .centeredVertically, animated: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    convenience init() {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        backgroundColor = .none
        register(DepartureCell.self, forCellWithReuseIdentifier: "DepartureCell")
        dataSource = self
        delegate = self
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "DepartureCell", for: indexPath) as! DepartureCell
        cell.style = (collectionView.suggestedSizeClass.vertical == .regular) ? .table : .collection
        cell.departure = departures[indexPath.row]
        cell.status = status[indexPath.row]
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView.suggestedSizeClass.vertical == .regular) {
            return CGSize(width: collectionView.bounds.size.width, height: (62.0 + suggestedContentInset.bottom * 2.0))
        } else {
            let insets: CGFloat = ((suggestedContentInset.left + suggestedContentInset.right) * 4) / 2.8
            return CGSize(width: (collectionView.bounds.size.width - insets) / 2.0, height: 62.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (suggestedSizeClass.vertical == .regular) ? 0.0 : suggestedContentInset.top
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return (suggestedSizeClass.vertical == .regular) ? .zero : suggestedContentInset
    }
    
    // MARK: UIScrollviewDelegate
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        canScroll = false
    }
}
