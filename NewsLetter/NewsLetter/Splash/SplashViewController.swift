//
//  SplashViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/03.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setup()
    }
    
    func setup() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
//        KeychainService.shared.deleteToken()

        guard KeychainService.shared.isTokenValidate() else {
            //토큰 유효하지 않으면 로그인화면으로 이동
            appDelegate.switchLogin()
            return
        }

        DataRequest.getUserInfo(){ data in
            MemberManager.shared.setNickName(data.nickname)
            MemberManager.shared.setUserId(data.userId)
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.switchHome()
            }
        } failure: { _ in
            KeychainService.shared.deleteToken()
            appDelegate.switchLogin()
        }
    }
    
    //자동 로그인 체크. 자동 로그인 되면 true 아니면 false리턴
//    func autoLoginProcess() -> Bool {
//        let loginManager = LoginManager.shared
//        if loginManager.memberInfo.isAutoLoginAction() {
//            loginManager.ssgLoginAction(){ status in
//                if status {
//                    //appDelegate.switchHome()

//                }
//                else {
    //                appDelegate.switchLogin()
//                }
//            }
//        }
//        else {
//            //로그인.회원가입 화면으로 전환
//        }
//        return false
    }
//}
