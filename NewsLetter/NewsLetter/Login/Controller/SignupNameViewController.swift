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
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var warningMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        nameTextField.attributedPlaceholder = NSAttributedString(string: "이름을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xdfdfdf)])
        nameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        nextButton.setImage(UIImage(named: "337ButtonInitial"), for: .normal)
        nextButton.setImage(UIImage(named: "337ButtonActive"), for: .highlighted)
        nameLabel.textColor = UIColor(rgb: 0x828282)
        clearButton.isHidden = true
        warningMsg.isHidden = true
        nameTextField.delegate = self
    }
    
    @IBAction func onNextButton(_ sender: UIButton) {
        guard checkNameValidate() else { return }
        guard let text = nameTextField.text, text.isValid else { return }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupEmailViewController") as? SignupEmailViewController else{
            return
        }
        let userData = DIR_User()
        userData.nickname = text
        vc.userData = userData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClearButton(_ sender: UIButton) {
        nameTextField.text = ""
        nameLabel.textColor = UIColor(rgb: 0x828282)
        warningMsg.isHidden = true
        clearButton.isHidden = true
    }
    
    func checkNameValidate() -> Bool{
        //이름 유효체크. 한글자~ 열글자
        guard let text = nameTextField.text else { return false }
        if text.count >= 1 {
            clearButton.isHidden = false
            nameLabel.textColor = UIColor(rgb: 0x333333)
            warningMsg.isHidden = true
            if text.count <= 10 {
                return true
            }
            else {
                nameLabel.textColor = UIColor(rgb: 0xeb5757)
                warningMsg.isHidden = false
                return false
            }
        }
        else {
            nameLabel.textColor = UIColor(rgb: 0x828282)
            warningMsg.isHidden = true
            clearButton.isHidden = true
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
