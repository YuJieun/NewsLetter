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

class LettersEditViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.collectionView.registerNibCell("SubscribeLetterCell", Classs: SubscribeLetterCell.self)
    }
}

extension LettersEditViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return EditSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case EditSection.services.rawValue:
            return 4
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
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
        case EditSection.services.rawValue:
            let size = SubscribeLetterCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
}
