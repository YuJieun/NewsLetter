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
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 11)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: UIColor(rgb:0x333333), alpha: 1, x: 0, y: -1, blur: 0)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
    }
}


extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 1,
        x: CGFloat = 0,
        y: CGFloat = -1,
        blur: CGFloat = 0
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}


extension UITabBar {
    // 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있다.
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
