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

    var rankingLetters: DI_MailList?
    var searchLetters: DI_MailList?

    var keyword: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerNibCell("SearchBarCell", Classs: SearchBarCell.self)
        self.collectionView.registerNibCell("SearchTitleCell", Classs: SearchTitleCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: SmallLetterBannerCell.self)
        setup()
    }

    func setup() {
        DataRequest.getMailRankingList() { [weak self] data in
            guard let `self` = self else { return }
            self.rankingLetters = data
            self.collectionView.reloadData()
        } failure: { _ in
            print("랭킹메일 못가져옴")
        }
    }

    func searchKeyword(_ keyword: String) {
        DataRequest.getMailSearch(keyword: keyword) { [weak self] data in
            guard let `self` = self else { return }
            self.searchLetters = data
            self.collectionView.reloadData()
        } failure: { _ in
            print("검색메일 못가져옴")
        }
    }

    func makeCellClosure() -> CellClosure {
        let cellClosure = { [weak self] type ,data in
            guard let `self` = self else { return }
            guard let type = type as? String else { return }
            if let type = MailCallbackType(rawValue: type) {
                switch type {
                case .letterDetail:
                    let storyboard = UIStoryboard(name: "MailDetail", bundle: nil)
                    guard let vc = storyboard.instantiateViewController(withIdentifier: "MailDetailViewController") as? MailDetailViewController else { return }
                    vc.tmpflag = true
                    self.navigationController?.pushViewController(vc, animated: true)
                case .bookmark:
                    self.setup()
                case .lock:
                    guard let data = data as? DI_Mail else { return }
                    let storyboard = UIStoryboard(name: "Alert", bundle: nil)
                    guard let vc = storyboard.instantiateViewController(withIdentifier: "CommonAlertViewController") as? CommonAlertViewController else { return }
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: false){
                        let data = DI_Alert()
                        data.infoLabel = "\(data.platformName)을\n아직 구독하지 않고 계시네요!\n구독하여 더 다양한 뉴스레터를\n받아보시겠어요?"
                        data.leftLabel = "다음에"
                        data.rightLabel = "구독할래요"
                        data.leftAction = { [weak self] _, _ in
                            print("구독구독")
                        }
                        vc.configure(data)
                    }
                default:
                    break
                }
            }
        }
        return cellClosure
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
            return self.rankingLetters?.resultList.count ?? 0 > 0 ? 1 : 0
        case SearchSection.searchResultLetters.rawValue:
            return self.rankingLetters?.resultList.count ?? 0
        case SearchSection.bookmarkTitle.rawValue:
            return self.rankingLetters?.resultList.count ?? 0 > 0 ? 1 : 0
        case SearchSection.bookmarkLetters.rawValue:
            return self.rankingLetters?.resultList.count ?? 0
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
                    self.searchKeyword(data)
                }
                else if type == "all" {
                    self.keyword = ""
                    self.searchLetters = nil
                    self.collectionView.reloadData()
                }
            }
            return cell
        case SearchSection.searchResultTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchTitleCell.self, "SearchTitleCell", for: indexPath)
            cell.configure(data: "\"\(self.keyword)\" 검색결과")
            return cell
        case SearchSection.searchResultLetters.rawValue:
            guard let searchLetters = self.searchLetters else { return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) }
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
            cell.configure(data: searchLetters[indexPath.row])
            cell.cellClosure = self.makeCellClosure()
            return cell
        case SearchSection.bookmarkTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchTitleCell.self, "SearchTitleCell", for: indexPath)
            cell.configure(data: "많은 유저들이 북마크했어요!")
            return cell
        case SearchSection.bookmarkLetters.rawValue:
            guard let rankingLetters = self.rankingLetters else { return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) }
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
            let item = rankingLetters[indexPath.row]
            item.rankingLabel = indexPath.row + 1
            cell.configure(data: item)
            cell.cellClosure = self.makeCellClosure()
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


