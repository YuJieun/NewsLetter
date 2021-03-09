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
            print(text)
        }
        else {
            print("없어")
        }
        nameTextField.text = ""
        nameTextField.resignFirstResponder()
    }
}
