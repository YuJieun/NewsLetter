//
//  LoginViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/10.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailInputBox: UITextField!
    @IBOutlet weak var passwordInputBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginButton(_ sender: UIButton) {
        guard checkInputAvailable() == true else { return }
        login()
    }
    
    //인풋박스 유효성 검사
    func checkInputAvailable() -> Bool {
        //1. 제대로 입력했으면 true반환
        //2. 제대로 입력안헀으면 경고주는창 띄우고 false반환
        return true
    }
    
    func login() {
        //이후에 이렇게 코드변경되어야함
        //로그인 요청하고 실패하면 얼럿창띄우고
        //성공하면 콜백타서 switchHome
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.switchHome()
        }
    }
    
}
