//
//  SettingViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import Foundation
import UIKit

enum SettingSection: Int, CaseIterable {
    case infoTitle = 0
    case profileEdit
    case lettersEdit
    case systemTitle
    case deleteAccount
}

class SettingViewController: CommonNavigationController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "설정"

//                    let yourBackImage = UIImage(named: "14BackPickygray")
//                    self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
//                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
//                    self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.isNavigationBarHidden = false
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setup() {
        self.collectionView.registerNibCell("SettingTitleCell", Classs: SettingTitleCell.self)
        self.collectionView.registerNibCell("SettingMenuCell", Classs: SettingMenuCell.self)
    }
}

extension SettingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SettingSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case SettingSection.infoTitle.rawValue:
            return 1
        case SettingSection.profileEdit.rawValue:
            return 1
        case SettingSection.lettersEdit.rawValue:
            return 1
        case SettingSection.systemTitle.rawValue:
            return 1
        case SettingSection.deleteAccount.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case SettingSection.infoTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingTitleCell.self, "SettingTitleCell", for: indexPath)
            cell.configure(data: "개인정보")
            return cell
        case SettingSection.profileEdit.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingMenuCell.self, "SettingMenuCell", for: indexPath)
            cell.configure(data: "내 프로필 수정")
            cell.cellClosure = { [weak self] _,_ in
                guard let `self` = self else { return }
                let storyboard = UIStoryboard(name: "Mypage", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ProfileEditViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case SettingSection.lettersEdit.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingMenuCell.self, "SettingMenuCell", for: indexPath)
            cell.configure(data: "구독메일 조회 및 편집")
            cell.cellClosure = { [weak self] _,_ in
                guard let `self` = self else { return }
                let storyboard = UIStoryboard(name: "Mypage", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LettersEditViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case SettingSection.systemTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingTitleCell.self, "SettingTitleCell", for: indexPath)
            cell.configure(data: "시스템")
            return cell
        case SettingSection.deleteAccount.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingMenuCell.self, "SettingMenuCell", for: indexPath)
            cell.configure(data: "탈퇴")
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case SettingSection.infoTitle.rawValue:
            let size = SettingTitleCell.getSize(nil)
            return size
        case SettingSection.profileEdit.rawValue:
            let size = SettingMenuCell.getSize(nil)
            return size
        case SettingSection.lettersEdit.rawValue:
            let size = SettingMenuCell.getSize(nil)
            return size
        case SettingSection.systemTitle.rawValue:
            let size = SettingTitleCell.getSize(nil)
            return size
        case SettingSection.deleteAccount.rawValue:
            let size = SettingMenuCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
    
}
