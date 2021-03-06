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
    var data: DI_MailList?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.registerNibCell("BigLetterBannerCell", Classs: BigLetterBannerCell.self)
        self.collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        setCollectionView()
    }
    
    override func prepareForReuse() {
        let point: CGPoint = CGPoint(x: 0 - 19, y: 0)
        self.collectionView.setContentOffset(point, animated: false)
    }
    
    func setCollectionView() {
        //셀너비
        let cellWidth:CGFloat = 320
        
        // 좌 여백
        let leftinset:CGFloat = 19
        
        // 우 여백
        let rightinset:CGFloat = UISCREEN_WIDTH - cellWidth - leftinset
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        collectionView.contentInset = UIEdgeInsets(top: 0, left: leftinset, bottom: 0, right: rightinset)
    }
    
    func configure(data: Any? = nil) {
        guard let data = data as? DI_MailList else { return }
        self.data = data
        self.collectionView.reloadData()
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
        return self.data?.resultList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = self.data else { return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) }
        let cell = collectionView.dequeueReusableCell(BigLetterBannerCell.self, "BigLetterBannerCell", for: indexPath)
        cell.configure(data: data.resultList[indexPath.row])
        cell.cellClosure = { [weak self] type ,data in
            guard let `self` = self else { return }
            self.cellClosure?(type, data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = BigLetterBannerCell.getSize(nil)
        return size
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //320 : 셀사이즈
        let cellWidthIncludingSpacing = 320 + layout.minimumLineSpacing

        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)

        if scrollView.contentOffset.x > targetContentOffset.pointee.x { roundedIndex = floor(index) }
        else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }

        if currentIndex > roundedIndex {
            currentIndex -= 1
            roundedIndex = currentIndex
        } else if currentIndex < roundedIndex {
            currentIndex += 1
            roundedIndex = currentIndex
        }

        offset = CGPoint(x: (roundedIndex * cellWidthIncludingSpacing) - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset

    }

}

