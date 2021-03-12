//
//  SignupEmailViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/10.
//

import UIKit

class SignupEmailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var warningMsg: UILabel!
    @IBOutlet weak var warningImg: UIImageView!
    @IBOutlet weak var clearButton: UIButton!
    
    var userData: DIR_User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let data = self.userData else { return }
        self.nameLabel.text = data.nickname
        
        emailField.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xdfdfdf)])
        emailField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        nextButton.setImage(UIImage(named: "337ButtonInitial"), for: .normal)
        nextButton.setImage(UIImage(named: "337ButtonActive"), for: .highlighted)
        emailLabel.textColor = UIColor(rgb: 0x828282)
        clearButton.isHidden = true
        warningMsg.isHidden = true
        warningImg.isHidden = true
        emailField.delegate = self
    }
    
    @IBAction func onNextButton(_ sender: UIButton) {
        guard let data = userData else { return }
        guard checkEmailValidate() else { return }
        guard let emailText = emailField.text, emailText.isValid else { return }
        DataRequest.postEmailCheck(param: emailText){ _ in
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupPasswordViewController") as? SignupPasswordViewController else{
                return
            }
            data.email = emailText
            vc.userData = data
            self.navigationController?.pushViewController(vc, animated: true)
        } failure: { _ in
            print("이메일 중복!! 요쪽 미완성임~~ㅎㅎ")
        }
    }
    
    @IBAction func onClearButton(_ sender: UIButton) {
        emailField.text = ""
        emailLabel.textColor = UIColor(rgb: 0x828282)
        warningMsg.isHidden = true
        warningImg.isHidden = true
        clearButton.isHidden = true
    }
    
    func checkEmailValidate() -> Bool {
        //이메일 유효체크
        guard let text = emailField.text, text.isValid else {
            emailLabel.textColor = UIColor(rgb: 0x828282)
            warningMsg.isHidden = true
            warningImg.isHidden = true
            clearButton.isHidden = true
            return false
        }
        clearButton.isHidden = false

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let flag = emailTest.evaluate(with: text)
        
        if flag {
            emailLabel.textColor = UIColor(rgb: 0x333333)
            warningMsg.isHidden = true
            warningImg.isHidden = true
            return true
        }
        else {
            emailLabel.textColor = UIColor(rgb: 0xeb5757)
            warningMsg.isHidden = false
            warningImg.isHidden = false
            return false
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.nextButton.isHighlighted = checkEmailValidate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
}
