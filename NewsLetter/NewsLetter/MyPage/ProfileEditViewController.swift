//
//  ProfileEditViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/18.
//

import Foundation
import UIKit

class ProfileEditViewController: CommonNavigationController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var customClosure: CellClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "내 프로필 수정"
        setTextFieldUI()
    }
    
    func setTextFieldUI() {
        self.nameTextField.layer.borderWidth = 1
        self.nameTextField.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.nameTextField.layer.cornerRadius = 3
        self.nameTextField.addLeftPadding()
        
        let rightButton = UIButton()
        let rightImage = UIImage(named: "changeFill")
        rightButton.setBackgroundImage(rightImage, for: .normal)
        rightButton.frame = CGRect(x: 0,y: 0, width: 71.4, height: 46)
        rightButton.addTarget(self, action: #selector(self.onButton), for: .touchUpInside)
        nameTextField.rightView = rightButton
        nameTextField.rightViewMode = UITextField.ViewMode.always
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    //돋보기 클릭
    @objc func onButton() {
        if let text = nameTextField.text, text.isValid {
            DataRequest.patchChangeNickname(nickname: text) { [weak self] data in
                guard let `self` = self else { return }
                MemberManager.shared.setNickName(data.nickname)
                self.customClosure?("",nil)
                self.nameTextField.text = ""
                self.nameTextField.resignFirstResponder()
                let storyboard = UIStoryboard(name: "Alert", bundle: nil)
                guard let vc = storyboard.instantiateViewController(withIdentifier: "CommonErrorViewController") as? CommonErrorViewController else { return }
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false){
                    let alertData = DI_Alert()
                    alertData.infoLabel = "닉네임 변경 완료"
                    alertData.leftLabel = "확인"
                    vc.configure(alertData)
                }
            } failure: { _ in
                print("메일 못가져옴")
            }
        }
        else {
            let storyboard = UIStoryboard(name: "Alert", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "CommonErrorViewController") as? CommonErrorViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false){
                let alertData = DI_Alert()
                alertData.infoLabel = "한글자 이상 입력해주세요"
                alertData.leftLabel = "확인"
                vc.configure(alertData)
            }
        }
    }
}
