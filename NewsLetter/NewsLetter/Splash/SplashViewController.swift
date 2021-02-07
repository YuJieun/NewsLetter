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
        
        print("check auto login")
        DataRequest.getWeatherApI(){(isAutoLogin, data) in
            if isAutoLogin {
                appDelegate.switchHome()
            }
            else {
                appDelegate.switchLogin()
            }
        } failure: { errstr in
            //그럼 얘는 스플래시에서 아예 안넘어가는거 알쥬?
            print(errstr)
        }
    }
    
    //자동 로그인 체크. 자동 로그인 되면 true 아니면 false리턴
//    func autoLoginProcess() -> Bool {
//        let loginManager = LoginManager.shared
//        if loginManager.memberInfo.isAutoLoginAction() {
//            loginManager.ssgLoginAction(){ status in
//                if status {
//                    //성공이면 홈화면으로 전환
//                }
//                else {
//                    //실패면 로그인, 회원가입 화면으로 전환
//                }
//            }
//        }
//        else {
//            //로그인.회원가입 화면으로 전환
//        }
//        return false
    }
//}
