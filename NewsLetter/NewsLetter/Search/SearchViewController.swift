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

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var keyword: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.collectionView.registerNibCell("SearchBarCell", Classs: SearchBarCell.self)
        self.collectionView.registerNibCell("SearchTitleCell", Classs: SearchTitleCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: SmallLetterBannerCell.self)
        setup()
    }

    func setup() {
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
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
            cell.configure(data: nil)
            return cell
        case SearchSection.bookmarkTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchTitleCell.self, "SearchTitleCell", for: indexPath)
            cell.configure(data: "많은 유저들이 북마크했어요!")
            return cell
        case SearchSection.bookmarkLetters.rawValue:
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
            cell.isRankingVisible = true
            cell.configure(data: "\(indexPath.row + 1)")
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


