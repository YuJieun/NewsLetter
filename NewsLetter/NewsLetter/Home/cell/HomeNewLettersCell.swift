//
//  HomeNewLettersCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/10.
//

import UIKit

class HomeNewLettersCell: CommonCollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var currentIndex: CGFloat = 0 // 현재 보여지고 있는 페이지의 인덱스
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.registerNibCell("BigLetterBannerCell", Classs: BigLetterBannerCell.self)
        setCollectionView()
    }
    
    func setCollectionView() {
        //셀 사이즈가 고정이어야할지, 아니면 좌우여백이 고정이어야할지는 고민해봐야할 문제..!(디자이너분과)
        
        //셀
        let cellWidth:CGFloat = 320
        
        // 좌우
        let inset:CGFloat = 19
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func configure(data: Any? = nil) {
//        guard let data = data as? String else { return }
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "HomeNewLettersCell").height)
    }

}

extension HomeNewLettersCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(BigLetterBannerCell.self, "BigLetterBannerCell", for: indexPath)
        cell.configure()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = BigLetterBannerCell.getSize(nil)
        return size
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        
//        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        var roundedIndex = round(index)
//
//        if scrollView.contentOffset.x > targetContentOffset.pointee.x { roundedIndex = floor(index) }
//        else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
//            roundedIndex = ceil(index)
//        } else {
//            roundedIndex = round(index)
//        }
//        
//        if currentIndex > roundedIndex {
//            currentIndex -= 1
//            roundedIndex = currentIndex
//        } else if currentIndex < roundedIndex {
//            currentIndex += 1
//            roundedIndex = currentIndex
//            
//        }
//
//        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//
//    }

}

