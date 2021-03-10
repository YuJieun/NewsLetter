//
//  SignupPasswordViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/10.
//

import Foundation
import UIKit

class SignupPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var secureButton: UIButton!
    
    @IBOutlet weak var pwdLabel: UILabel!
    @IBOutlet weak var warningMsg: UILabel!
    
    var userData: DIR_User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let data = self.userData else { return }
        self.emailField.text = data.email
        self.nameField.text = data.nickname
        
        secureButton.setImage(UIImage(named: "16ClosedEyes"), for: .normal)
        secureButton.setImage(UIImage(named: "16OpenedEyes"), for: .selected)
        pwdField.attributedPlaceholder = NSAttributedString(string: "8자리 이상 비밀번호를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xdfdfdf)])
        pwdField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        nextButton.setImage(UIImage(named: "337ButtonInitial_2"), for: .normal)
        nextButton.setImage(UIImage(named: "337ButtonActive_2"), for: .highlighted)
        pwdLabel.textColor = UIColor(rgb: 0x828282)
        warningMsg.isHidden = true
        pwdField.delegate = self
    }
    
    
    @IBAction func onNextButton(_ sender: UIButton) {
        guard let data = userData else { return }
        guard checkPasswordValidate() else { return }
        guard let pwdText = pwdField.text, pwdText.isValid else { return }
        data.password = pwdText
        signup()
    }
    
    @IBAction func onSecureButton(_ sender: UIButton) {
        pwdField.isSecureTextEntry = !pwdField.isSecureTextEntry
        secureButton.isSelected = !secureButton.isSelected
    }
    
    func checkPasswordValidate() -> Bool {
        //8자리 이상
        guard let text = pwdField.text else {
            pwdLabel.textColor = UIColor(rgb: 0x828282)
            return false
        }
        if text.count < 8 {
            pwdLabel.textColor = UIColor(rgb: 0xeb5757)
            warningMsg.isHidden = false
            return false
        }
        else {
            pwdLabel.textColor = UIColor(rgb: 0x333333)
            warningMsg.isHidden = true
            return true
        }
    }
    
    func signup() {
        //회원가입 요청하고 실패하면 얼럿
        //성공하면 콜백타서 switchHome
        guard let userData = self.userData else { return }
        DataRequest.postJoin(param: userData){ user in
//            guard user is DI_User else { return }
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.switchLogin()
            }
        } failure: { error in
            print(error?.localizedDescription ?? "")
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.nextButton.isHighlighted = checkPasswordValidate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
}
