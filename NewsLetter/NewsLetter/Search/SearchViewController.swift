//
//  SearchViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import UIKit

enum SearchSection: Int, CaseIterable {
    case searchBar
    case searchResultTitle
    case searchResultLetters
    case bookmarkTitle
    case bookmarkLetters
}

class SearchViewController: CommonViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var keyword: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerNibCell("SearchBarCell", Classs: SearchBarCell.self)
        self.collectionView.registerNibCell("SearchTitleCell", Classs: SearchTitleCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: SmallLetterBannerCell.self)
        setup()
    }

    func setup() {
        
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SearchSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case SearchSection.searchBar.rawValue:
            return 1
        case SearchSection.searchResultTitle.rawValue:
            if self.keyword.isValid {
                return 1
            }
            else {
                return 0
            }
        case SearchSection.searchResultLetters.rawValue:
            if self.keyword.isValid {
                return 2
            }
            else {
                return 0
            }
        case SearchSection.bookmarkTitle.rawValue:
            return 1
        case SearchSection.bookmarkLetters.rawValue:
            return 10
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case SearchSection.searchBar.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchBarCell.self, "SearchBarCell", for: indexPath)
            cell.configure()
            cell.cellClosure = { [weak self] type, data in
                guard let `self` = self else { return }
                if type == "keyword" {
                    guard let data = data as? String else { return }
                    self.keyword = data
                    self.collectionView.reloadData()
                }
                else if type == "all" {
                    self.keyword = ""
                    self.collectionView.reloadData()
                }
            }
            return cell
        case SearchSection.searchResultTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchTitleCell.self, "SearchTitleCell", for: indexPath)
            cell.configure(data: "\"\(self.keyword)\" 검색결과")
            return cell
        case SearchSection.searchResultLetters.rawValue:
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
            cell.row = indexPath.row
            cell.isLock = false
            cell.isRankingVisible = false
            cell.configure(data: nil)
            return cell
        case SearchSection.bookmarkTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchTitleCell.self, "SearchTitleCell", for: indexPath)
            cell.configure(data: "많은 유저들이 북마크했어요!")
            return cell
        case SearchSection.bookmarkLetters.rawValue:
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
            cell.row = indexPath.row
            cell.isRankingVisible = true
            if indexPath.row == 3 || indexPath.row == 7 {
                cell.isLock = true
            }
            else {
                cell.isLock = false
            }
            cell.configure(data: "\(indexPath.row + 1)")
            cell.cellClosure = { [weak self] type ,_ in
                guard let `self` = self else { return }
                
                switch type {
                case "letter":
                    let storyboard = UIStoryboard(name: "MailDetail", bundle: nil)
                    guard let vc = storyboard.instantiateViewController(withIdentifier: "MailDetailViewController") as? MailDetailViewController else { return }
                    vc.tmpflag = true
                    self.navigationController?.pushViewController(vc, animated: true)
                case "lock":
                    let storyboard = UIStoryboard(name: "Alert", bundle: nil)
                    guard let vc = storyboard.instantiateViewController(withIdentifier: "CommonAlertViewController") as? CommonAlertViewController else { return }
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: false){
                        let data = DI_Alert()
                        data.infoLabel = "디독을\n아직 구독하지 않고 계시네요!\n구독하여 더 다양한 뉴스레터를\n받아보시겠어요?"
                        data.leftLabel = "다음에"
                        data.rightLabel = "구독할래요"
                        data.leftAction = { [weak self] _, _ in
                            //탈퇴 기능 추가
                            print("구독구독")
                        }
                        vc.configure(data)
                    }
                default:
                    break
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
        case SearchSection.searchBar.rawValue:
            let size = SearchBarCell.getSize(nil)
            return size
        case SearchSection.searchResultTitle.rawValue:
            let size = SearchTitleCell.getSize(nil)
            return size
        case SearchSection.searchResultLetters.rawValue:
            let size = SmallLetterBannerCell.getSize(nil)
            return size
        case SearchSection.bookmarkTitle.rawValue:
            let size = SearchTitleCell.getSize(nil)
            return size
        case SearchSection.bookmarkLetters.rawValue:
            let size = SmallLetterBannerCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
}


