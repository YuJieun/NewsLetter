//
//  LettersEditViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/18.
//

import Foundation
import UIKit

enum EditSection: Int, CaseIterable {
    case search
    case services
}

class LettersEditViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.collectionView.registerNibCell("SearchBarCell", Classs: SearchBarCell.self)
        self.collectionView.registerNibCell("SubscribeLetterCell", Classs: SubscribeLetterCell.self)
    }
}

extension LettersEditViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return EditSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case EditSection.search.rawValue:
            return 1
        case EditSection.services.rawValue:
            return 4
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case EditSection.search.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchBarCell.self, "SearchBarCell", for: indexPath)
            cell.configure(data: "구독레터 서비스명을 검색하세요.")
            return cell
        case EditSection.services.rawValue:
            let cell = collectionView.dequeueReusableCell(SubscribeLetterCell.self, "SubscribeLetterCell", for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case EditSection.search.rawValue:
            let size = SearchBarCell.getSize(nil)
            return size
        case EditSection.services.rawValue:
            let size = SubscribeLetterCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
}
