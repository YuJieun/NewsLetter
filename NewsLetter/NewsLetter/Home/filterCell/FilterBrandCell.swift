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
//        let fixedHeight = titleView.heightConstraint

        return CGSize(width: UISCREEN_WIDTH, height: 200)
    }
}

extension FilterBrandCell: UICollectionViewDelegate, UICollevtionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(BigLetterBannerCell.self, "BigLetterBannerCell", for: indexPath)
        return cell
    }
}
