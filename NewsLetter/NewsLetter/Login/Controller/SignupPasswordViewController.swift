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
    
    var userData: DIR_User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let data = self.userData else { return }
        self.emailField.text = data.email
        self.nameField.text = data.name
        
        secureButton.setImage(UIImage(named: "16ClosedEyes"), for: .normal)
        secureButton.setImage(UIImage(named: "16OpenedEyes"), for: .selected)
        pwdField.attributedPlaceholder = NSAttributedString(string: "8자리 이상 비밀번호를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xdfdfdf)])
        pwdField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        nextButton.setImage(UIImage(named: "337ButtonInitial_2"), for: .normal)
        nextButton.setImage(UIImage(named: "337ButtonActive_2"), for: .highlighted)
        pwdField.delegate = self
    }
    
    
    @IBAction func onNextButton(_ sender: UIButton) {
        guard checkPasswordValidate() else { return }
        guard let pwdText = pwdField.text, pwdText.isValid else { return }
        signup()
    }
    
    @IBAction func onSecureButton(_ sender: UIButton) {
        pwdField.isSecureTextEntry = !pwdField.isSecureTextEntry
        secureButton.isSelected = !secureButton.isSelected
    }
    
    func checkPasswordValidate() -> Bool {
        //유효하지 않으면 alert and return false
        return true
    }
    
    func signup() {
        //이후에 코드추가
        //회원가입 요청하고 실패하면 얼럿
        //성공하면 콜백타서 switchHome
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.switchLogin()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.nextButton.isHighlighted = self.pwdField.text?.isValid  ?? false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
}
