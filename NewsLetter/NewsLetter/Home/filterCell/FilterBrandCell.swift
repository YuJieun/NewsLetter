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

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.registerNibCell("FilterBrandItemCell", Classs: FilterBrandItemCell.self)
    }

    func configure(data: Any? = nil) {
        guard let _ = data else { return }

    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        let cell = Self.getXib(className: "FilterBrandCell", as: self)
        cell.configure()
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
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let arr = ["디독", "뉴미디어", "유지은", "레인보우레인보우아이렇게길면어떻게나오나", "엥","중간길이", "테스트용이지롱", "와우우우우우우"]
        let cell = collectionView.dequeueReusableCell(FilterBrandItemCell.self, "FilterBrandItemCell", for: indexPath)
        cell.configure(data: arr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let arr = ["디독", "뉴미디어", "유지은", "레인보우레인보우아이렇게길면어떻게나오나", "엥","중간길이", "테스트용이지롱", "와우우우우우우"]
        let size = FilterBrandItemCell.getSize(arr[indexPath.row])
        return size
    }
    
}
