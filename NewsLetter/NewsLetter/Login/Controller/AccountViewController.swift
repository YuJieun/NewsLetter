//
//  AccountViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import Foundation
import UIKit


class AccountViewController: CommonViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pwdSecureButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        pwdSecureButton.setImage(UIImage(named: "16ClosedEyes"), for: .normal)
        pwdSecureButton.setImage(UIImage(named: "16OpenedEyes"), for: .selected)
        loginButton.setImage(UIImage(named: "337ButtonInitial_login"), for: .normal)
        loginButton.setImage(UIImage(named: "337ButtonActive_login"), for: .highlighted)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xdfdfdf), NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Medium", size: 18)!])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xdfdfdf), NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Medium", size: 18)!])
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

    }
    
    @IBAction func onPwdSecureButton(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        pwdSecureButton.isSelected = !pwdSecureButton.isSelected
    }
    
    //로그인 버튼
    @IBAction func onSigninButton(_ sender: UIButton) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.switchHome()
        }
    }
 
    //회원가입 버튼
    @IBAction func onSignupButton(_ sender: UIButton) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") else{
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
    }
}


extension AccountViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if checkEmailValidate() && checkPasswordValidate() {
            self.loginButton.isHighlighted = true
        }
        else {
            self.loginButton.isHighlighted = false
        }
    }
    
    func checkEmailValidate() -> Bool{
        guard let text = emailTextField.text else { return false }
        if text.isValid {
            return true
        }
        return false
    }
    
    func checkPasswordValidate() -> Bool{
        guard let text = passwordTextField.text else { return false }
        if text.isValid {
            return true
        }
        return false
    }
}
