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
        //자동로그인 체크
        appDelegate.switchLogin()
//        DataRequest.getWeatherApI(){(isAutoLogin, data) in
//            if isAutoLogin {
//                appDelegate.switchHome()
//            }
//            else {
//                appDelegate.switchLogin()
//            }
//        } failure: { error in
//            //그럼 얘는 스플래시에서 아예 안넘어가는거 알쥬?
//            //실패시 뭐할건지 처리..!
//            print(error?.localizedDescription ?? "")
//        }
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
