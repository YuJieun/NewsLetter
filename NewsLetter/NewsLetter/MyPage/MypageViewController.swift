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
    private var refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerNibCell("MypageProfileCell", Classs: MypageProfileCell.self)
        self.collectionView.registerNibCell("SearchTitleCell", Classs: SearchTitleCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: SmallLetterBannerCell.self)
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        setup()
    }

    func setup() {
        CustomLoadingView.show()
        DataRequest.getBookMarkList(id: 0){ [weak self] data in
            guard let `self` = self else { return }
            self.bookmarkList = data
            if data.resultList.count > 0 {
                self.moreRequest()
            }
            else {
                self.collectionView.reloadData()
                CustomLoadingView.hide()
            }
        } failure: { _ in
            print("북마크 메일 못가져옴")
        }
    }
    
    func moreRequest() {
        guard let bookmarkList = self.bookmarkList else {
            self.collectionView.reloadData()
            return
        }
        let lastid = bookmarkList.resultList[bookmarkList.resultList.count - 1].letterId
        DataRequest.getBookMarkList(id: lastid){ [weak self] data in
            guard let `self` = self else { return }
            guard let bookmarkList = self.bookmarkList else { return }
            if data.resultList.count > 0 {
                bookmarkList.resultList.append(contentsOf: data.resultList)
                self.moreRequest()
            }
            else {
                self.collectionView.reloadData()
                CustomLoadingView.hide()
            }
        } failure: { _ in
            print("북마크 메일 못가져옴")
        }
    }
    
    @objc private func refresh(){
        self.setup()
        self.refreshControl.endRefreshing()
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
                guard let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController else { return }
                vc.customClosure = { [weak self] type, _ in
                    guard let self = self else { return }
                    if type == "profile" {
                        self.collectionView.reloadSections([MypageSection.profile.rawValue])
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.configure()
            return cell
        case MypageSection.title.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchTitleCell.self, "SearchTitleCell", for: indexPath)
            cell.configure(data: "나의 북마크 (\(self.bookmarkList?.resultList.count ?? 0))")
            return cell
        case MypageSection.letters.rawValue:
            guard let bookmarkList = self.bookmarkList else { return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) }
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
            cell.configure(data: bookmarkList.resultList[indexPath.row])
            cell.cellClosure = { [weak self] (type,data) in
                guard let `self` = self else { return }
                guard let data = data as? DI_Mail else { return }
                if let type = MailCallbackType(rawValue: type) {
                    switch type {
                    case .letterDetail:
                        let storyboard = UIStoryboard(name: "MailDetail", bundle: nil)
                        guard let  vc = storyboard.instantiateViewController(withIdentifier: "MailDetailViewController") as? MailDetailViewController else { return }
                        vc.letterId = data.letterId
                        self.navigationController?.pushViewController(vc, animated: true)
                    default:
                        break
                    }
                }
            }
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
