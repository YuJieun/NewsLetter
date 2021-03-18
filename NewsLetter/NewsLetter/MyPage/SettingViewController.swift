//
//  SettingViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import Foundation
import UIKit

enum SettingSection: Int, CaseIterable {
    case infoTitle = 0
    case profileEdit
    case lettersEdit
    case divideLine
    case systemTitle
    case contact
    case logout
    case deleteAccount
}

class SettingViewController: CommonNavigationController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var customClosure: CellClosure?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "설정"
        setup()
    }
    
    func setup() {
        self.collectionView.registerNibCell("SettingTitleCell", Classs: SettingTitleCell.self)
        self.collectionView.registerNibCell("SettingMenuCell", Classs: SettingMenuCell.self)
        self.collectionView.registerNibCell("SettingDivideCell", Classs: SettingDivideCell.self)
    }
}

extension SettingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SettingSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case SettingSection.infoTitle.rawValue:
            return 1
        case SettingSection.profileEdit.rawValue:
            return 1
        case SettingSection.lettersEdit.rawValue:
            return 1
        case SettingSection.divideLine.rawValue:
            return 1
        case SettingSection.systemTitle.rawValue:
            return 1
        case SettingSection.contact.rawValue:
            return 1
        case SettingSection.logout.rawValue:
            return 1
        case SettingSection.deleteAccount.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case SettingSection.infoTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingTitleCell.self, "SettingTitleCell", for: indexPath)
            cell.configure(data: "개인정보")
            return cell
        case SettingSection.profileEdit.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingMenuCell.self, "SettingMenuCell", for: indexPath)
            cell.configure(data: "내 프로필 수정")
            cell.cellClosure = { [weak self] _,_ in
                guard let `self` = self else { return }
                let storyboard = UIStoryboard(name: "Mypage", bundle: nil)
                guard let vc = storyboard.instantiateViewController(withIdentifier: "ProfileEditViewController") as? ProfileEditViewController else { return }
                vc.customClosure = { [weak self] _, _ in
                    guard let `self` = self else { return }
                    self.customClosure?("profile",nil)
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case SettingSection.lettersEdit.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingMenuCell.self, "SettingMenuCell", for: indexPath)
            cell.configure(data: "구독메일 조회 및 편집")
            cell.cellClosure = { [weak self] _,_ in
                guard let `self` = self else { return }
                let storyboard = UIStoryboard(name: "Mypage", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LettersEditViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case SettingSection.divideLine.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingDivideCell.self, "SettingDivideCell", for: indexPath)
            cell.configure(data: nil)
            return cell
        case SettingSection.systemTitle.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingTitleCell.self, "SettingTitleCell", for: indexPath)
            cell.configure(data: "시스템")
            return cell
        case SettingSection.contact.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingMenuCell.self, "SettingMenuCell", for: indexPath)
            cell.configure(data: "고객센터")
            cell.cellClosure = { _,_ in
                let email = "makeus.pineapple@gmail.com"
                let subject = "피키레터 - 문의메일"
                let bodyText = ""
                
                let coded = "mailto:\(email)?subject=\(subject)&body=\(bodyText)"
                                        .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                if let url = URL(string: coded!) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            return cell
        case SettingSection.logout.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingMenuCell.self, "SettingMenuCell", for: indexPath)
            cell.configure(data: "로그아웃")
            cell.cellClosure = {[weak self] _, _ in
                guard let `self` = self else { return }
                let storyboard = UIStoryboard(name: "Alert", bundle: nil)
                guard let vc = storyboard.instantiateViewController(withIdentifier: "CommonAlertViewController") as? CommonAlertViewController else { return }
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false){
                    let data = DI_Alert()
                    data.infoLabel = "정말 로그아웃하시겠습니까?"
                    data.leftLabel = "로그아웃"
                    data.rightLabel = "안할래요"
                    data.leftAction = { _, _ in
                        //탈퇴 기능 추가
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                        KeychainService.shared.deleteToken()
                        appDelegate.switchLogin()
                    }
                    vc.configure(data)
                }
            }
            return cell
        case SettingSection.deleteAccount.rawValue:
            let cell = collectionView.dequeueReusableCell(SettingMenuCell.self, "SettingMenuCell", for: indexPath)
            cell.configure(data: "탈퇴")
            cell.cellClosure = {[weak self] _, _ in
                guard let `self` = self else { return }
                let storyboard = UIStoryboard(name: "Alert", bundle: nil)
                guard let vc = storyboard.instantiateViewController(withIdentifier: "CommonAlertViewController") as? CommonAlertViewController else { return }
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false){
                    let data = DI_Alert()
                    data.infoLabel = "정말 탈퇴하실건가요?"
                    data.leftLabel = "탈퇴할래요"
                    data.rightLabel = "안할래요"
                    data.leftAction = { _, _ in
                        DataRequest.deleteAccount(){ _ in
                            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                            KeychainService.shared.deleteToken()
                            appDelegate.switchLogin()
                        } failure: { _ in
                        }
                    }
                    vc.configure(data)
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
        case SettingSection.infoTitle.rawValue:
            let size = SettingTitleCell.getSize(nil)
            return size
        case SettingSection.profileEdit.rawValue:
            let size = SettingMenuCell.getSize(nil)
            return size
        case SettingSection.lettersEdit.rawValue:
            let size = SettingMenuCell.getSize(nil)
            return size
        case SettingSection.divideLine.rawValue:
            let size = SettingDivideCell.getSize(nil)
            return size
        case SettingSection.systemTitle.rawValue:
            let size = SettingTitleCell.getSize(nil)
            return size
        case SettingSection.contact.rawValue:
            let size = SettingMenuCell.getSize(nil)
            return size
        case SettingSection.logout.rawValue:
            let size = SettingMenuCell.getSize(nil)
            return size
        case SettingSection.deleteAccount.rawValue:
            let size = SettingMenuCell.getSize(nil)
            return size
        default:
            return .zero
        }
    }
    
}
