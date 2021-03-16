//
//  MypageViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import UIKit

enum MypageSection: Int, CaseIterable {
    case profile
    case title
    case letters
}

class MypageViewController: UIViewController {

    var bookmarkList: DI_MailList?

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerNibCell("MypageProfileCell", Classs: MypageProfileCell.self)
        self.collectionView.registerNibCell("SearchTitleCell", Classs: SearchTitleCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: SmallLetterBannerCell.self)
        setup()
    }

    func setup() {
        DataRequest.getBookMarkList(){ [weak self] data in
            guard let `self` = self else { return }
            self.bookmarkList = data
            self.collectionView.reloadData()
        } failure: { _ in
            print("북마크 메일 못가져옴")
        }
    }
}

extension MypageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MypageSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case MypageSection.profile.rawValue:
            return 1
        case MypageSection.title.rawValue:
            return 1
        case MypageSection.letters.rawValue:
            return self.bookmarkList?.resultList.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case MypageSection.profile.rawValue:
            let cell = collectionView.dequeueReusableCell(MypageProfileCell.self, "MypageProfileCell", for: indexPath)
            cell.cellClosure = { [weak self] _,_ in
                guard let `self` = self else { return }
                let storyboard = UIStoryboard(name: "Mypage", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case MypageSection.title.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchTitleCell.self, "SearchTitleCell", for: indexPath)
            cell.configure(data: "나의 북마크 (\(self.bookmarkList?.resultList.count ?? 0))")
            return cell
        case MypageSection.letters.rawValue:
            guard let bookmarkList = self.bookmarkList else { return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) }
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
            cell.configure(data: bookmarkList.resultList[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case MypageSection.profile.rawValue:
            let size = MypageProfileCell.getSize(nil)
            return size
        case MypageSection.title.rawValue:
            let size = SearchTitleCell.getSize(nil)
            return size
        case MypageSection.letters.rawValue:
            let size = SmallLetterBannerCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
    
}
