//
//  FilterViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/09.
//

import Foundation
import UIKit

enum FilterSection: Int, CaseIterable {
    case title
    case brand
    case date
}

//할 것
/*
 1. topView height 정해주기
 */

class FilterViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    
    //필터 데이터
    var filterData: DIR_Mail?
    
    //구독중인 플랫폼
    var platforms: DI_PlatformList?
    var totalData = DI_Platform()
    
    var customClosure: CellClosure?
    
    override func viewDidLoad() {
        setup()
    }
    
    func setup() {
        collectionView.layer.cornerRadius = 10
        self.collectionView.registerNibCell("FilterTitleCell", Classs: FilterTitleCell.self)
        self.collectionView.registerNibCell("FilterBrandCell", Classs: FilterBrandCell.self)
        self.collectionView.registerNibCell("FilterDateCell", Classs: FilterDateCell.self)
        view.isOpaque = false
        let color = UIColor(rgb: 0x333333).withAlphaComponent(0.5)
        view.backgroundColor = color
        
//        brandRequest()
    }
 
    
//    func brandRequest() {
//        DataRequest.getSubscribingPlatforms() { [weak self] data in
//            guard let `self` = self else { return }
//            self.platforms = data
//            for item in data.resultList {
//                item.isSelected = false
//            }
//            self.totalData.name = "전체"
//            self.totalData.isSelected = true
//            self.collectionView.reloadData()
//        } failure: { _ in
//            print("플랫폼목록 못가져옴")
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTopView(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return FilterSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case FilterSection.title.rawValue:
            return 1
        case FilterSection.brand.rawValue:
            if let _ = self.filterData, let _ = self.platforms {
                return 1
            }
            else {
                return 0
            }
        case FilterSection.date.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case FilterSection.title.rawValue:
            let cell = collectionView.dequeueReusableCell(FilterTitleCell.self, "FilterTitleCell", for: indexPath)
            cell.cellClosure = { [weak self] _,_ in
                guard let `self` = self else { return }
                self.customClosure?("",nil)
                self.dismiss(animated: true, completion: nil)
            }
            return cell
        case FilterSection.brand.rawValue:
            let cell = collectionView.dequeueReusableCell(FilterBrandCell.self, "FilterBrandCell", for: indexPath)
            cell.totalData = totalData
            cell.configure(data: self.platforms)
            cell.cellClosure = { [weak self] (type, platform) in
                guard let self = self else { return }
                guard let filterData = self.filterData else { return }
                guard let platform = platform as? DI_Platform else { return }
                if type == "delete" {
                    if let index = filterData.platforms.firstIndex(of: platform.name) {
                        filterData.platforms.remove(at: index)
                        if filterData.platforms.count == 0 {
                            self.totalData.isSelected = true
                        }
                        self.collectionView.reloadSections(IndexSet([FilterSection.brand.rawValue]))
                    }
                }
                else if type == "add" {
                    filterData.platforms.append(platform.name)
                    self.totalData.isSelected = false
                    self.collectionView.reloadSections(IndexSet([FilterSection.brand.rawValue]))
                }
            }
            return cell
        case FilterSection.date.rawValue:
//            let dateData = DI_FilterDate()
            let cell = collectionView.dequeueReusableCell(FilterDateCell.self, "FilterDateCell", for: indexPath)
            cell.configure(data: self.filterData)
            cell.cellClosure = { [weak self] _, data in
                guard let self = self else { return }
                self.collectionView.reloadSections(IndexSet([FilterSection.date.rawValue]))
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case FilterSection.title.rawValue:
            let size = FilterTitleCell.getSize(nil)
            return size
        case FilterSection.brand.rawValue:
            let size = FilterBrandCell.getSize(self.platforms)
            return size
        case FilterSection.date.rawValue:
            let size = FilterDateCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
    
}

