//
//  FilterBrandCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit

class FilterBrandCell: CommonCollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleView: UIView!
    
    var brands: DI_PlatformList?
    var totalData: DI_Platform?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.registerNibCell("FilterBrandItemCell", Classs: FilterBrandItemCell.self)
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }

    func configure(data: Any? = nil) {
        guard let data = data as? DI_PlatformList else { return }
        self.brands = data
        self.collectionView.reloadData()
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        guard let data = data as? DI_PlatformList else { return .zero }
        let cell = Self.getXib(className: "FilterBrandCell", as: self)
        cell.configure(data: data)
        cell.collectionView.reloadData()
        cell.collectionView.layoutIfNeeded()
        let fixedHeight = cell.titleView.h + cell.collectionView.bottomConstraint
        let collectionViewHeight = cell.collectionView.contentSize.height
        return CGSize(width: UISCREEN_WIDTH, height: fixedHeight + collectionViewHeight)
    }
}

extension FilterBrandCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.brands?.resultList.count ?? 0) + 1 //전체 셀 포함
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let brands = self.brands else { return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) }
        let cell = collectionView.dequeueReusableCell(FilterBrandItemCell.self, "FilterBrandItemCell", for: indexPath)
        if indexPath.row == 0 {
            cell.configure(data: totalData)
        }
        else {
            cell.configure(data: brands.resultList[indexPath.row - 1])
            cell.cellClosure = { [weak self] (type, data) in
                guard let self = self else { return }
                self.cellClosure?(type, data)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let brands = self.brands else { return .zero }
        if indexPath.row == 0 {
            return FilterBrandItemCell.getSize(totalData)
        }
        else {
            return FilterBrandItemCell.getSize(brands.resultList[indexPath.row - 1])
        }
    }
    
}
