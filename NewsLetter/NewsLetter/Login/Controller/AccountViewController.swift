//
//  AccountViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import Foundation
import UIKit


class AccountViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
    }
    
    //로그인 버튼
    @IBAction func onSigninButton(_ sender: UIButton) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") else{
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    
    //회원가입 버튼
    @IBAction func onSignupButton(_ sender: UIButton) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") else{
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
    }
}
