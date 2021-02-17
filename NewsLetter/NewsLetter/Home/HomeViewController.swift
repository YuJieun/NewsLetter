//
//  HomeViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import Foundation
import UIKit

enum HomeSection: Int, CaseIterable {
    case mainTitle = 0
    case newLetters
    case filterBar
    case oldLetters
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("홈메뉴")
        self.collectionView.registerNibCell("HomeTitleCell", Classs: HomeTitleCell.self)
        self.collectionView.registerNibCell("HomeNewLettersCell", Classs: HomeTitleCell.self)
        self.collectionView.registerNibCell("HomeFilterBarCell", Classs: HomeTitleCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: HomeTitleCell.self)
        setup()
    }
    
    func setup() {
        
    }
}


//호출순서..이후에 이거 확인해봐야할듯.! setup과 collectionView채우는순서
/*
 UIViewController.viewDidLoad
 UIViewController.viewDidLayoutSubviews
 UICollectionViewDataSource.collectionView(_, numberOfItemsInSection)
 UICollectionViewDelegateFlowLayout.collectionView(_, layout, sizeForItemAt)
 UICollectionViewCell.preferredLayoutAttributesFitting

 */
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case HomeSection.mainTitle.rawValue:
            return 1
        case HomeSection.newLetters.rawValue:
            return 1
        case HomeSection.filterBar.rawValue:
            return 1
        case HomeSection.oldLetters.rawValue:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case HomeSection.mainTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(HomeTitleCell.self, "HomeTitleCell", for: indexPath)
            return cell
            
        case HomeSection.newLetters.rawValue:
            let cell = collectionView.dequeueReusableCell(HomeNewLettersCell.self, "HomeNewLettersCell", for: indexPath)
            cell.configure(data: nil)
            return cell
        case HomeSection.filterBar.rawValue:
            let cell = collectionView.dequeueReusableCell(HomeFilterBarCell.self, "HomeFilterBarCell", for: indexPath)
            cell.cellClosure = { [weak self] _,_ in
                guard let `self` = self else { return }
                self.definesPresentationContext = true
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier:  "FilterViewController")
                vc.modalPresentationStyle = .overCurrentContext
               self.present(vc, animated: true)
            }
            return cell
        case HomeSection.oldLetters.rawValue:
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case HomeSection.mainTitle.rawValue:
            let size = HomeTitleCell.getSize(nil)
            return size
            
        case HomeSection.newLetters.rawValue:
            let size = HomeNewLettersCell.getSize(nil)
            return size
        
        case HomeSection.filterBar.rawValue:
            let size = HomeFilterBarCell.getSize(nil)
            return size
        case HomeSection.oldLetters.rawValue:
            let size = SmallLetterBannerCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
}
