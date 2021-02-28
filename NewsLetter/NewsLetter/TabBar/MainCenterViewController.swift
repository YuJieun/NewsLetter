//
//  MainCenterViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import Foundation
import UIKit

class MainCenterViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 12)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        
        UITabBar.appearance().barTintColor = UIColor.white
        self.tabBar.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.tabBar.layer.borderWidth = 1
    }
}
