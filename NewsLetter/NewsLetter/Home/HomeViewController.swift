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
    var hasMoreLetters: Bool = false
    
    //MARK:- 데이터
    var oldLetters: DI_MailList?
    var newLetters: DI_MailList?
    
    //지난 레터 request데이터
    var filterData: DIR_Mail?
    
    //필터
    var platforms: DI_PlatformList?
    var totalData = DI_Platform()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerNibCell("HomeTitleCell", Classs: HomeTitleCell.self)
        self.collectionView.registerNibCell("HomeNoTitleCell", Classs: HomeNoTitleCell.self)
        self.collectionView.registerNibCell("HomeNewLettersCell", Classs: HomeNewLettersCell.self)
        self.collectionView.registerNibCell("HomeNoLetterCell", Classs: HomeNoLetterCell.self)
        self.collectionView.registerNibCell("HomeFilterBarCell", Classs: HomeFilterBarCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: SmallLetterBannerCell.self)
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = .clear
                
//        CustomLoadingView.show()
//        setup() // 설정에서 닉네임 셋팅땜에 setup() 위치 바꿔야할 것 같긴 하다...
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup() // 설정에서 닉네임 셋팅땜에 setup() 위치 바꿔야할 것 같긴 하다...
    }
    
    func setup() {
        CustomLoadingView.show()
        self.getNewLetters()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let end = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let endDate = formatter.string(from: end!)

        let requestData = DIR_Mail()
        requestData.startDate = nil
        requestData.endDate = endDate
        requestData.page = 0
        self.filterData = requestData
        self.getOldLetters()
        self.brandRequest()
        self.hasMoreLetters = true
    }

    func getNewLetters() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current = formatter.string(from: Date())
        
        let start = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let startDate = formatter.string(from: start! )

        let requestData = DIR_Mail()
        requestData.startDate = startDate
        requestData.endDate = current
        requestData.page = 0
        DataRequest.getMailList(parameter: requestData) { [weak self] data in
            guard let `self` = self else { return }
            self.newLetters = data
            self.collectionView.reloadSections(IndexSet([HomeSection.newLetters.rawValue]))
        } failure: { _ in
            print("메일 못가져옴")
        }
    }

    func getOldLetters() {
        guard let filterData = self.filterData else { return }
        DataRequest.getMailList(parameter: filterData) { [weak self] data in
            guard let `self` = self else { return }
//            self.newLetters = data
            self.oldLetters = data
            self.collectionView.reloadSections(IndexSet([HomeSection.oldLetters.rawValue]))
        } failure: { _ in
            print("메일 못가져옴")
        }
    }
    
    func brandRequest() {
        DataRequest.getSubscribingPlatforms() { [weak self] data in
            guard let `self` = self else { return }
            self.platforms = data
            for item in data.resultList {
                item.isSelected = false
            }
            self.totalData.name = "전체"
            self.totalData.isSelected = true
            CustomLoadingView.hide()
        } failure: { _ in
            print("플랫폼목록 못가져옴")
        }
    }
    
    
    @objc private func refresh(){
        self.setup()
        self.refreshControl.endRefreshing()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y != 0 {
            guard hasMoreLetters == true else { return }
            guard let filterData = self.filterData else { return }
            
            hasMoreLetters = false
            filterData.page += 1
            DataRequest.getMailList(parameter: filterData) { [weak self] data in
                guard let `self` = self else { return }
                if data.resultList.count > 0 {
                    self.hasMoreLetters = true
                    self.oldLetters?.resultList.append(contentsOf: data.resultList)
                    self.collectionView.reloadSections(IndexSet([HomeSection.oldLetters.rawValue]))
                }
            } failure: { _ in
                print("메일 못가져옴")
            }
        }
    }

    func checkMoreLetters(_ collectionView: UICollectionView) {
        guard hasMoreLetters == true else { return }
        guard let filterData = self.filterData else { return }
        
        let offsety = collectionView.contentOffset.y
        let contentHeight = collectionView.contentSize.height

        if offsety > contentHeight - collectionView.frame.height
        {
            hasMoreLetters = false
            filterData.page += 1
            DataRequest.getMailList(parameter: filterData) { [weak self] data in
                guard let `self` = self else { return }
                if data.resultList.count > 0 {
                    self.hasMoreLetters = true
                    self.oldLetters = data
                    self.collectionView.reloadSections(IndexSet([HomeSection.oldLetters.rawValue]))
                }
            } failure: { _ in
                print("메일 못가져옴")
            }
        }
      
        /*let contentSize: CGFloat
        let offsetY: CGFloat

        contentSize = collectionView.contentSize.height - UISCREEN_HEIGHT * 3
        offsetY = collectionView.contentOffset.y + collectionView.h
        
        if offsetY >= contentSize || contentSize <= 0 {
//            hasMoreLetters = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001, execute: {
                self.collectionView.reloadData()
            })
        }*/
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let isNewLetterValid: Bool = self.newLetters?.resultList.count ?? 0 > 0 ? true : false
        switch section {
        case HomeSection.mainTitle.rawValue:
            return isNewLetterValid ? 1 : 0
        case HomeSection.noLetterTitle.rawValue:
            return isNewLetterValid ? 0 : 1
        case HomeSection.newLetters.rawValue:
            return isNewLetterValid ? 1 : 0
        case HomeSection.noLetters.rawValue:
            return isNewLetterValid ? 0 : 1
        case HomeSection.filterBar.rawValue:
            return 1
        case HomeSection.oldLetters.rawValue:
            return self.oldLetters?.resultList.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        defer {
//            checkMoreLetters(collectionView)
//        }
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
                guard let vc = storyboard.instantiateViewController(withIdentifier:  "FilterViewController") as? FilterViewController else { return }
                vc.modalPresentationStyle = .overCurrentContext
                vc.filterData = self.filterData
                vc.platforms = self.platforms
                vc.totalData = self.totalData
                vc.customClosure = { [weak self] _, _ in
                    guard let self = self else { return }
                    self.filterData?.page = 0
                    self.getOldLetters()
                }
                self.present(vc, animated: true)
            }
            return cell
        case HomeSection.oldLetters.rawValue:
            guard let oldLetters = self.oldLetters else { return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) }
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
            cell.configure(data: oldLetters.resultList[indexPath.row])
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
