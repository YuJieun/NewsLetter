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
    
    var userData: DIR_User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let data = self.userData else { return }
        self.nameLabel.text = data.name
        
        emailField.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xdfdfdf)])
        emailField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        nextButton.setImage(UIImage(named: "337ButtonInitial"), for: .normal)
        nextButton.setImage(UIImage(named: "337ButtonActive"), for: .highlighted)
        emailField.delegate = self
    }
    
    @IBAction func onNextButton(_ sender: UIButton) {
        guard let data = userData else { return }
        guard checkEmailValidate() else { return }
        guard let emailText = emailField.text, emailText.isValid else { return }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupPasswordViewController") as? SignupPasswordViewController else{
            return
        }
        data.email = emailText
        vc.userData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkEmailValidate() -> Bool {
        //이메일 유효체크
        //유효하지 않으면 alert and return false
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.nextButton.isHighlighted = self.emailField.text?.isValid ?? false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
}
