//
//  SignupNameViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import Foundation
import UIKit


class SignupNameViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        nameTextField.attributedPlaceholder = NSAttributedString(string: "이름을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xdfdfdf)])
        nameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        nextButton.setImage(UIImage(named: "337ButtonInitial"), for: .normal)
        nextButton.setImage(UIImage(named: "337ButtonActive"), for: .highlighted)
        nameTextField.delegate = self
    }
    
    @IBAction func onNextButton(_ sender: UIButton) {
        guard checkNameValidate() else { return }
        guard let text = nameTextField.text, text.isValid else { return }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupEmailViewController") as? SignupEmailViewController else{
            return
        }
        let userData = DIR_User()
        userData.name = text
        vc.userData = userData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkNameValidate() -> Bool{
        //이름 유효체크
        //유효하지않으면 alert and return false
        guard let text = nameTextField.text else { return false }
        if text.isValid {
            return true
        }
        else {
            return false
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.nextButton.isHighlighted = checkNameValidate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
}
