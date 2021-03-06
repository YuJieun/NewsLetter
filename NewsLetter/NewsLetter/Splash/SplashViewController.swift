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
            MemberManager.shared.setEmail(data.email)
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.switchHome()
            }
        } failure: { _ in
            KeychainService.shared.deleteToken()
            appDelegate.switchLogin()
        }
    }
}
