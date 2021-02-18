//
//  SearchViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import UIKit

enum SearchSection: Int, CaseIterable {
    case searchBar
    case title
    case letters
}

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        self.collectionView.registerNibCell("SearchBarCell", Classs: SearchBarCell.self)
        self.collectionView.registerNibCell("SearchTitleCell", Classs: SearchTitleCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: SmallLetterBannerCell.self)


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
        case SearchSection.title.rawValue:
            return 1
        case SearchSection.letters.rawValue:
            return 10
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case SearchSection.searchBar.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchBarCell.self, "SearchBarCell", for: indexPath)
            cell.configure(data: "궁금한 뉴스레터를 검색하세요")
            return cell
        case SearchSection.title.rawValue:
            let cell = collectionView.dequeueReusableCell(SearchTitleCell.self, "SearchTitleCell", for: indexPath)
            return cell
        case SearchSection.letters.rawValue:
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
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
        case SearchSection.title.rawValue:
            let size = SearchTitleCell.getSize(nil)
            return size
        case SearchSection.letters.rawValue:
            let size = SmallLetterBannerCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
}
