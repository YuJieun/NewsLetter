//
//  AppDelegate.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let root = storyboard.instantiateViewController(withIdentifier: "SplashViewController")
        let nvc = UINavigationController(rootViewController: root)
        nvc.isNavigationBarHidden = true
        
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func switchLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AccountViewController")
        let nvc = UINavigationController(rootViewController: vc)
        nvc.isNavigationBarHidden = true
//        nvc.interactivePopGestureRecognizer?.isEnabled = false //얠 추가하면 스와이프로 뒤로가기 막을수있음
        
        self.window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
        
    func switchHome() {
        let storyboard = UIStoryboard(name: "MainCenter", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainCenterViewController")
        let nvc = UINavigationController(rootViewController: vc)
        nvc.isNavigationBarHidden = true
        
        self.window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
}

