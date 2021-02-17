//
//  FilterViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/09.
//

import Foundation
import UIKit

enum FilterSection: Int, CaseIterable {
    case title
    case brand
    case date
}

class FilterViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        setup()
    }
    
    func setup() {
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        self.collectionView.registerNibCell("FilterTitleCell", Classs: FilterTitleCell.self)
        self.collectionView.registerNibCell("FilterBrandCell", Classs: FilterBrandCell.self)
        self.collectionView.registerNibCell("FilterDateCell", Classs: FilterDateCell.self)
    }
    
    @IBAction func onTopView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return FilterSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case FilterSection.title.rawValue:
            return 1
        case FilterSection.brand.rawValue:
            return 1
        case FilterSection.date.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case FilterSection.title.rawValue:
            let cell = collectionView.dequeueReusableCell(FilterTitleCell.self, "FilterTitleCell", for: indexPath)
            cell.cellClosure = { [weak self] _,_ in
                guard let `self` = self else { return }
                self.dismiss(animated: true, completion: nil)
            }
            return cell
        case FilterSection.brand.rawValue:
            let cell = collectionView.dequeueReusableCell(FilterBrandCell.self, "FilterBrandCell", for: indexPath)
            return cell
        case FilterSection.date.rawValue:
            let cell = collectionView.dequeueReusableCell(FilterDateCell.self, "FilterDateCell", for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case FilterSection.title.rawValue:
            let size = FilterTitleCell.getSize(nil)
            return size
        case FilterSection.brand.rawValue:
            let size = FilterBrandCell.getSize(nil)
            return size
        case FilterSection.date.rawValue:
            let size = FilterDateCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
    
}

