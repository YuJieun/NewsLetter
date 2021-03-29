//
//  LettersEditViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/18.
//

import Foundation
import UIKit

enum EditSection: Int, CaseIterable {
    case services
}

class LettersEditViewController: CommonNavigationController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: DI_PlatformList?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "구독메일 조회 및 편집"
        setup()
    }
    
    func setup() {
        self.collectionView.registerNibCell("SubscribeLetterCell", Classs: SubscribeLetterCell.self)
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        request()
    }
    
    func request() {
        DataRequest.getTotalPlatforms() { [weak self] data in
            guard let `self` = self else { return }
            self.data = data
            self.collectionView.reloadData()
        } failure: { _ in
            print("플랫폼목록 못가져옴")
        }
    }
    
}

extension LettersEditViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return EditSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case EditSection.services.rawValue:
            return self.data?.resultList.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case EditSection.services.rawValue:
            guard let data = self.data else { return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) }
            let cell = collectionView.dequeueReusableCell(SubscribeLetterCell.self, "SubscribeLetterCell", for: indexPath)
            if indexPath.row == data.resultList.count - 1 {
                cell.isBottomViewVisible = false
            }
            else {
                cell.isBottomViewVisible = true
            }
            cell.configure(data: data.resultList[indexPath.row])
            cell.cellClosure = { [weak self] _, _ in
                guard let self = self else { return }
                self.request()
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case EditSection.services.rawValue:
            let size = SubscribeLetterCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
}
