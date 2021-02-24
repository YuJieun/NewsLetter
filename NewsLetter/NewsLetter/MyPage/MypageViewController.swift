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

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerNibCell("MypageProfileCell", Classs: MypageProfileCell.self)
        self.collectionView.registerNibCell("MypageTitleCell", Classs: MypageTitleCell.self)
        self.collectionView.registerNibCell("SmallLetterBannerCell", Classs: SmallLetterBannerCell.self)
        setup()
    }
    
    func setup() {
        //1. 회원데이터 변수에 저장.
        //2. 이제 그 회원데이터로 통신
        //3. 나의 북마크 정보 가져오기
        DataRequest.getBookMark(){(data) in
            guard let data = data as? DI_BookMarkList else { return }
            
        } failure: { error in
            print(error?.localizedDescription ?? "")
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
            return 10
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
            let cell = collectionView.dequeueReusableCell(MypageTitleCell.self, "MypageTitleCell", for: indexPath)
            return cell
        case MypageSection.letters.rawValue:
            let cell = collectionView.dequeueReusableCell(SmallLetterBannerCell.self, "SmallLetterBannerCell", for: indexPath)
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
            let size = MypageTitleCell.getSize(nil)
            return size
        case MypageSection.letters.rawValue:
            let size = SmallLetterBannerCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
    
}
