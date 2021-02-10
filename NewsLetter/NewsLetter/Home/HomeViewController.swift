//
//  HomeViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import Foundation
import UIKit

enum HomeSection: Int, CaseIterable {
    case title = 0
    case something
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("홈메뉴")
        self.collectionView.registerNibCell("HomeTitleCell", Classs: HomeTitleCell.self)
        setup()
    }
    
    func setup() {
        
    }
}


//호출순서
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
        case HomeSection.title.rawValue:
            return 1
        case HomeSection.something.rawValue:
            return 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case HomeSection.title.rawValue:
            let cell = collectionView.dequeueReusableCell(HomeTitleCell.self, "HomeTitleCell", for: indexPath)
            cell.configure(data: "냥냥펀치")
            cell.cellClosure = {[weak self] _,_ in
                guard let `self` = self else { return }
                self.definesPresentationContext = true
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier:  "FilterViewController")
                vc.modalPresentationStyle = .overCurrentContext
               self.present(vc, animated: true)
            }
            return cell
            
        case HomeSection.something.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case HomeSection.title.rawValue:
            let size = HomeTitleCell.getSize(nil)
            return size
            
        case HomeSection.something.rawValue:
            return .zero
            
        default:
            return .zero
        }
    }
}
