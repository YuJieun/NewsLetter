//
//  HomeNewLettersCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/10.
//

import UIKit

class HomeNewLettersCell: CommonCollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.registerNibCell("BigLetterBannerCell", Classs: BigLetterBannerCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func configure(data: Any? = nil) {
//        guard let data = data as? String else { return }
        self.collectionView.reloadData()
    }

 
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 300)
    }

}

extension HomeNewLettersCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(BigLetterBannerCell.self, "BigLetterBannerCell", for: indexPath)
        return cell
    }
    
    
}
