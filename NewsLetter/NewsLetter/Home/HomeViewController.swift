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
    var newLetters: DI_MailList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("홈메뉴")
        self.collectionView.registerNibCell("HomeTitleCell", Classs: HomeTitleCell.self)
        self.collectionView.registerNibCell("HomeNoTitleCell", Classs: HomeNoTitleCell.self)
        self.collectionView.registerNibCell("HomeNewLettersCell", Classs: HomeNewLettersCell.self)
        self.collectionView.registerNibCell("HomeNoLetterCell", Classs: HomeNoLetterCell.self)
        self.collectionView.registerNibCell("HomeFilterBarCell", Classs: HomeFilterBarCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: SmallLetterBannerCell.self)
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")

        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
                
        setup() // 설정에서 닉네임 셋팅땜에 setup() 위치 바꿔야할 것 같긴 하다...
    }
    
    func setup() {
        self.getNewLetters()
        self.getOldLetters()
    }

    func getNewLetters() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current = formatter.string(from: Date())
        
        let start = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let startDate = formatter.string(from: start! )

        let requestData = DIR_Mail(startDate: startDate, endDate: current, page: 0)
        DataRequest.getMailList(parameter: requestData) { [weak self] data in
            guard let `self` = self else { return }
            self.newLetters = data
            self.collectionView.reloadSections(IndexSet([HomeSection.newLetters.rawValue]))
        } failure: { _ in
            print("메일 못가져옴")
        }
    }

    func getOldLetters() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//
//        let end = Calendar.current.date(byAdding: .day, value: -7, to: Date())
//        let endDate = formatter.string(from: end!)
//
//        let requestData = DIR_Mail(startDate: nil, endDate: endDate, page: 0)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current = formatter.string(from: Date())
        
        let start = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let startDate = formatter.string(from: start! )

        let requestData = DIR_Mail(startDate: startDate, endDate: current, page: 0)
//        DataRequest.getMailList(parameter: requestData) { [weak self] data in
//            guard let `self` = self else { return }
//            self.oldLetters = data
//            self.collectionView.reloadSections(IndexSet([HomeSection.oldLetters.rawValue]))
//        } failure: { _ in
//            print("메일 못가져옴")
//        }
        DataRequest.getMailList(parameter: requestData) { [weak self] data in
            guard let `self` = self else { return }
            self.oldLetters = data
            self.collectionView.reloadSections(IndexSet([HomeSection.oldLetters.rawValue]))
        } failure: { _ in
            print("메일 못가져옴")
        }
    }
    
    @objc private func refresh(){
        self.setup()
        self.refreshControl.endRefreshing()
    }


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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let isNewLetterValid: Bool = self.newLetters?.resultList.count ?? 0 > 0 ? true : false
        let isOldLetterValid: Bool = self.oldLetters?.resultList.count ?? 0 > 0 ? true : false
        switch section {
        case HomeSection.mainTitle.rawValue:
            return isNewLetterValid ? 1 : 0
        case HomeSection.noLetterTitle.rawValue:
            return isNewLetterValid ? 0 : 1
        case HomeSection.newLetters.rawValue:
            return isNewLetterValid ? 1 : 0
        case HomeSection.noLetters.rawValue:
            return isOldLetterValid ? 0 : 1
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
            cell.configure(data: self.newLetters)
            cell.cellClosure = { [weak self] type, data in
                guard let `self` = self else { return }
                guard let data = data as? DI_Mail else { return }
                if let type = MailCallbackType(rawValue: type) {
                    switch type {
                    case .letterDetail:
                        let storyboard = UIStoryboard(name: "MailDetail", bundle: nil)
                        guard let  vc = storyboard.instantiateViewController(withIdentifier: "MailDetailViewController") as? MailDetailViewController else { return }
                        vc.letterId = data.letterId
                        self.navigationController?.pushViewController(vc, animated: true)
                    case .bookmark:
                        self.getNewLetters()
                        //이후에 newletter섹션만 reload하기
                    default:
                        break
                    }
                }
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
            cell.configure(data: oldLetters.resultList[indexPath.row])
            cell.cellClosure = { [weak self] (type,data) in
                guard let `self` = self else { return }
                guard let type = type as? String else { return }
                if let type = MailCallbackType(rawValue: type) {
                    switch type {
                    case .letterDetail:
                        let storyboard = UIStoryboard(name: "MailDetail", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "MailDetailViewController")
                        self.navigationController?.pushViewController(vc, animated: true)
                    case .bookmark:
                        self.getOldLetters()
                        //이후에 oleLetter섹션만 reload하기
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
