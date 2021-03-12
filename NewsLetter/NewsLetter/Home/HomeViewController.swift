//
//  HomeViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import Foundation
import UIKit

enum HomeSection: Int, CaseIterable {
    case mainTitle = 0
    case noLetterTitle
    case newLetters
    case noLetters
    case filterBar
    case oldLetters
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var refreshControl = UIRefreshControl()
    var hasMoreLetters: Bool = true
    
    //MARK:- 데이터
    var oldLetters: DI_MailList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("홈메뉴")
        self.collectionView.registerNibCell("HomeTitleCell", Classs: HomeTitleCell.self)
        self.collectionView.registerNibCell("HomeNoTitleCell", Classs: HomeNoTitleCell.self)
        self.collectionView.registerNibCell("HomeNewLettersCell", Classs: HomeNewLettersCell.self)
        self.collectionView.registerNibCell("HomeNoLetterCell", Classs: HomeNoLetterCell.self)
        self.collectionView.registerNibCell("HomeFilterBarCell", Classs: HomeFilterBarCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: SmallLetterBannerCell.self)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
                
        setup()
    }
    
    func setup() {
        DataRequest.getMailList() { [weak self] data in
            guard let `self` = self else { return }
            self.oldLetters = data
            self.collectionView.reloadData()
        } failure: { _ in
            print("메일 못가져옴")
        }
    }
    
    @objc private func refresh(){
        // Fetch Weather Data
        self.setup()
//            fetchWeatherData()
        self.refreshControl.endRefreshing()
    }
    
//    private func fetchWeatherData() {
//        dataManager.weatherDataForLocation(latitude: 37.8267, longitude: -122.423) { (location, error) in
//            DispatchQueue.main.async {
//                if let location = location {
//                    self.days = location.days
//                }
//
//                self.updateView()
//                self.refreshControl.endRefreshing()
//                self.activityIndicatorView.stopAnimating()
//            }
//        }
//    }
//    refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
//    refreshControl.attributedTitle = NSAttributedString(string: "Fetching Weather Data ...", attributes: attributes)


    func checkMoreLetters(_ collectionView: UICollectionView) {
        
        /* 첫번째 케이스
        let offsety = collectionView.contentOffset.y
        let contentHeight = collectionView.contentSize.height

        if offsety > contentHeight - collectionView.frame.height
        {
            
        }
         */
        
        guard hasMoreLetters == true else { return }
        let contentSize: CGFloat
        let offsetY: CGFloat

        contentSize = collectionView.contentSize.height - UISCREEN_HEIGHT * 3
        offsetY = collectionView.contentOffset.y + collectionView.h
        
        if offsetY >= contentSize || contentSize <= 0 {
            hasMoreLetters = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001, execute: {
                self.collectionView.reloadData()
            })
        }
    }
}


//호출순서..이후에 이거 확인해봐야할듯.! setup과 collectionView채우는순서
/*
 UIViewController.viewDidLoad
 UIViewController.viewDidLayoutSubviews
 UICollectionViewDataSource.collectionView(_, numberOfItemsInSection)
 UICollectionViewDelegateFlowLayout.collectionView(_, layout, sizeForItemAt)
 UICollectionViewCell.preferredLayoutAttributesFitting

 */
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case HomeSection.mainTitle.rawValue:
            return 1
        case HomeSection.noLetterTitle.rawValue:
            return 0
        case HomeSection.newLetters.rawValue:
            return 1
        case HomeSection.noLetters.rawValue:
            return 0
        case HomeSection.filterBar.rawValue:
            return 1
        case HomeSection.oldLetters.rawValue:
            return self.oldLetters?.resultList.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        defer {
            checkMoreLetters(collectionView)
        }
        switch indexPath.section {
        case HomeSection.mainTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(HomeTitleCell.self, "HomeTitleCell", for: indexPath)
            cell.configure(data: MemberManager.shared.getNickName())
            return cell
        case HomeSection.noLetterTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(HomeNoTitleCell.self, "HomeNoTitleCell", for: indexPath)
            return cell
        case HomeSection.newLetters.rawValue:
            let cell = collectionView.dequeueReusableCell(HomeNewLettersCell.self, "HomeNewLettersCell", for: indexPath)
            cell.configure(data: nil)
            cell.cellClosure = { [weak self] _,_ in
                guard let `self` = self else { return }
                let storyboard = UIStoryboard(name: "MailDetail", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MailDetailViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case HomeSection.noLetters.rawValue:
            let cell = collectionView.dequeueReusableCell(HomeNoLetterCell.self, "HomeNoLetterCell", for: indexPath)
            return cell
        case HomeSection.filterBar.rawValue:
            let cell = collectionView.dequeueReusableCell(HomeFilterBarCell.self, "HomeFilterBarCell", for: indexPath)
            cell.cellClosure = { [weak self] _,_ in
                guard let `self` = self else { return }
                self.definesPresentationContext = true
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier:  "FilterViewController")
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true)
            }
            return cell
        case HomeSection.oldLetters.rawValue:
            guard let oldLetters = self.oldLetters else { return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) }
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
//            cell.row = indexPath.row
            //데이터 넘길때 rankingVisible도 같이 넘기기
            cell.isRankingVisible = false
            cell.configure(data: oldLetters.resultList[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case HomeSection.mainTitle.rawValue:
            let size = HomeTitleCell.getSize(nil)
            return size
        case HomeSection.noLetterTitle.rawValue:
            let size = HomeNoTitleCell.getSize(nil)
            return size
        case HomeSection.newLetters.rawValue:
            let size = HomeNewLettersCell.getSize(nil)
            return size
        case HomeSection.noLetters.rawValue:
            let size = HomeNoLetterCell.getSize(nil)
            return size
        case HomeSection.filterBar.rawValue:
            let size = HomeFilterBarCell.getSize(nil)
            return size
        case HomeSection.oldLetters.rawValue:
            let size = SmallLetterBannerCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
}
