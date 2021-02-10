//
//  SignupPasswordViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/10.
//

import Foundation
import UIKit

class SignupPasswordViewController: UIViewController {
    
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var userData: DIR_User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let data = self.userData else { return }
        self.emailLabel.text = data.email
        self.nameLabel.text = data.name
    }
    
    
    @IBAction func onNextButton(_ sender: UIButton) {
        guard checkPasswordValidate() else { return }
        signup()
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
            appDelegate.switchHome()
        }

    }
}
